import 'dart:async';

import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/services.dart';

import 'wavebrook.dart';

class Settings {
  static const CHANNEL_SETTINGS = "${Wavebrook.CHANNEL_MAIN}/settings";

  static const MethodChannel _channel = const MethodChannel(CHANNEL_SETTINGS);

  static Future<bool?> get backgroundLocationEnable async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;
    return await _channel.invokeMethod<bool>('getBackgroundLocationEnabled');
  }

  static Future<bool> get isBackgroundLocationEnabled async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('isBackgroundLocationEnabled') ?? false;
  }

  static Future<void> setBackgroundLocationEnabled(bool? enable) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    Map<String, dynamic> values = {
      'enable': enable,
    };

    await _channel.invokeMethod('setBackgroundLocationEnabled', values);
  }
}
