import 'dart:async';

import 'package:flutter/services.dart';

import 'wavebrook.dart';

class Settings {
  static const CHANNEL_SETTINGS = "${Wavebrook.CHANNEL_MAIN}/settings";

  static const MethodChannel _channel = const MethodChannel(CHANNEL_SETTINGS);

  static Future<bool?> get backgroundLocationEnable async {
    return await _channel.invokeMethod('getBackgroundLocationEnabled');
  }

  static Future<bool> get isBackgroundLocationEnabled async {
    return await _channel.invokeMethod('isBackgroundLocationEnabled');
  }

  static Future<void> setBackgroundLocationEnabled(bool? enable) async {
    Map<String, dynamic> values = {
      'enable': enable,
    };

    await _channel.invokeMethod('setBackgroundLocationEnabled', values);
  }
}
