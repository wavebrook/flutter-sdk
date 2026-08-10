import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wavebrook/wavebrook.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('wavebrook');

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

  test('initialize sends assetKey and start and returns the result', () async {
    response = true;

    final ready = await Wavebrook.initialize('key-123', start: false);

    expect(ready, isTrue);
    expect(calls.single.method, 'initialize');
    expect(calls.single.arguments, {'assetKey': 'key-123', 'start': false});
  });

  test('initialize defaults start to true and false on null result', () async {
    final ready = await Wavebrook.initialize('key-123');

    expect(ready, isFalse);
    expect(calls.single.arguments, {'assetKey': 'key-123', 'start': true});
  });

  test('foundAdapters casts the native list', () async {
    response = ['cellrebel', 'ipinfo'];

    expect(await Wavebrook.foundAdapters, ['cellrebel', 'ipinfo']);
    expect(calls.single.method, 'foundAdapters');
  });

  test('state getters call the right methods', () async {
    response = true;

    expect(await Wavebrook.isInitialized, isTrue);
    expect(await Wavebrook.isReady, isTrue);
    expect(await Wavebrook.isStarted, isTrue);
    expect(await Wavebrook.waitForInitialization(), isTrue);
    expect(calls.map((c) => c.method), ['isInitialized', 'isReady', 'isStarted', 'waitForInitialization']);
  });

  test('versionName uses getVersionName and defaults to empty', () async {
    expect(await Wavebrook.versionName, '');
    expect(calls.single.method, 'getVersionName');
  });

  test('lifecycle methods send no arguments', () async {
    await Wavebrook.start();
    await Wavebrook.stop();
    await Wavebrook.clearUserData();

    expect(calls.map((c) => c.method), ['start', 'stop', 'clearUserData']);
  });

  test('disableAdapter sends id and disable', () async {
    await Wavebrook.disableAdapter('cellrebel', true);

    expect(calls.single.method, 'disableAdapter');
    expect(calls.single.arguments, {'disable': true, 'id': 'cellrebel'});
  });

  test('unsupported platforms never touch the channel', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

    expect(await Wavebrook.initialize('key-123'), isFalse);
    expect(await Wavebrook.foundAdapters, isEmpty);
    expect(await Wavebrook.versionName, '');
    expect(calls, isEmpty);
  });
}
