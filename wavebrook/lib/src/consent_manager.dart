import 'dart:async';

import 'package:flutter/services.dart';

import 'wavebrook.dart';

class ConsentManager {
  static const CHANNEL_CONSENT = "${Wavebrook.CHANNEL_MAIN}/consentManager";

  static const MethodChannel _channel = const MethodChannel(CHANNEL_CONSENT);

  static Future<bool> get canCollectPersonalData async {
    return await _channel.invokeMethod('canCollectPersonalData');
  }

  static Future<Map<String, dynamic>?> get data async {
    dynamic result = await _channel.invokeMethod('get');

    return result?.cast<String, dynamic>();
  }

  static Future<void> enableTcfMonitor(bool enable) async {
    Map<String, dynamic> values = {
      'enable': enable,
    };

    await _channel.invokeMethod('enableTcfMonitor', values);
  }

  static Future<bool> get exists async {
    return await _channel.invokeMethod('exists');
  }

  static Future<bool?> get isGranted async {
    return await _channel.invokeMethod('isGranted');
  }

  static Future<bool?> request({bool withOptOut = false}) async {
    Map<String, dynamic> values = {
      'withOptOut': withOptOut,
    };

    return await _channel.invokeMethod('request', values);
  }

  static Future<bool?> requestOnce({bool withOptOut = false}) async {
    Map<String, dynamic> values = {
      'withOptOut': withOptOut,
    };

    return await _channel.invokeMethod('requestOnce', values);
  }

  static Future<void> set(bool granted) async {
    Map<String, dynamic> values = {
      'granted': granted,
    };

    await _channel.invokeMethod('set', values);
  }

  static Future<void> setIabString(String value) async {
    Map<String, dynamic> values = {
      'value': value,
    };

    await _channel.invokeMethod('setIabString', values);
  }
}
