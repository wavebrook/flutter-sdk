import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wavebrook/wavebrook.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('wavebrook/consentManager');

  final calls = <MethodCall>[];

  dynamic response;

  setUp(() {
    calls.clear();
    response = null;
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return response;
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('set sends granted', () async {
    await ConsentManager.set(true);

    expect(calls.single.method, 'set');
    expect(calls.single.arguments, {'granted': true});
  });

  test('setIabString sends value', () async {
    await ConsentManager.setIabString('CQAbc');

    expect(calls.single.method, 'setIabString');
    expect(calls.single.arguments, {'value': 'CQAbc'});
  });

  test('enableTcfMonitor sends enable', () async {
    await ConsentManager.enableTcfMonitor(false);

    expect(calls.single.method, 'enableTcfMonitor');
    expect(calls.single.arguments, {'enable': false});
  });

  test('isGranted passes null through', () async {
    expect(await ConsentManager.isGranted, isNull);
    expect(calls.single.method, 'isGranted');
  });

  test('booleans default to false on null result', () async {
    expect(await ConsentManager.canCollectPersonalData, isFalse);
    expect(await ConsentManager.exists, isFalse);
    expect(calls.map((c) => c.method), ['canCollectPersonalData', 'exists']);
  });

  test('data parses the native map into ConsentData', () async {
    final date = DateTime.utc(2026, 7, 4, 6, 16, 46);

    response = {
      'date': date.millisecondsSinceEpoch,
      'granted': true,
      'iabString': 'CQAbc',
      'source': 'EXTERNAL',
    };

    final data = await ConsentManager.data;

    expect(calls.single.method, 'get');
    expect(data!.granted, isTrue);
    expect(data.iabString, 'CQAbc');
    expect(data.source, 'EXTERNAL');
    expect(data.date, date);
  });

  test('data returns null when the native side has none', () async {
    expect(await ConsentManager.data, isNull);
  });

  test('ConsentData.fromMap tolerates missing keys', () {
    final data = ConsentData.fromMap({'granted': true});

    expect(data.granted, isTrue);
    expect(data.date, isNull);
    expect(data.iabString, isNull);
    expect(data.source, isNull);
  });
}
