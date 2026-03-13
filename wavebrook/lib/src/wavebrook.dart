import 'dart:async';

import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/services.dart';

class Wavebrook {
  static const CHANNEL_MAIN = "wavebrook";

  static const MethodChannel _channel = const MethodChannel(CHANNEL_MAIN);

  static Future<void> clearUserData() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _channel.invokeMethod('clearUserData');
  }

  static Future<void> disableAdapter(String id, bool disable) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    Map<String, dynamic> values = {
      'disable': disable,
      'id': id
    };

    await _channel.invokeMethod('disableAdapter', values);
  }

  static Future<void> enableBackgroundLocation(bool? enable) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    Map<String, dynamic> values = {
      'enable': enable,
    };

    await _channel.invokeMethod('enableBackgroundLocation', values);
  }

  static Future<List<String>> get foundAdapters async {
    if (defaultTargetPlatform != TargetPlatform.android) return [];

    final List<dynamic>? result = await _channel.invokeMethod('foundAdapters');
    return result?.cast<String>() ?? [];
  }

  static Future<bool> initialize(String assetKey, {bool start = true}) async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;

    Map<String, dynamic> values = {
      'assetKey': assetKey,
      'start': start,
    };

    return await _channel.invokeMethod<bool>('initialize', values) ?? false;
  }

  static Future<bool> get isInitialized async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('isInitialized') ?? false;
  }

  static Future<bool> get isReady async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('isReady') ?? false;
  }

  static Future<bool> get isStarted async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('isStarted') ?? false;
  }

  static Future<void> start() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _channel.invokeMethod('start');
  }

  static Future<bool> startAdaptersActivity() async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('startAdaptersActivity') ?? false;
  }

  static Future<void> stop() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    await _channel.invokeMethod('stop');
  }

  static Future<String> get versionName async {
    if (defaultTargetPlatform != TargetPlatform.android) return '';
    return await _channel.invokeMethod<String>('getVersionName') ?? '';
  }

  static Future<bool> waitForInitialization() async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('waitForInitialization') ?? false;
  }
}
