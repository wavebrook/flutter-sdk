import 'dart:async';

import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/services.dart';

import 'wavebrook.dart';

class ConsentManager {
  static const CHANNEL_CONSENT = "${Wavebrook.CHANNEL_MAIN}/consentManager";

  static const MethodChannel _channel = const MethodChannel(CHANNEL_CONSENT);

  static Future<bool> get canCollectPersonalData async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('canCollectPersonalData') ?? false;
  }

  static Future<Map<String, dynamic>?> get data async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;

    dynamic result = await _channel.invokeMethod('get');

    return result?.cast<String, dynamic>();
  }

  static Future<void> enableTcfMonitor(bool enable) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    Map<String, dynamic> values = {
      'enable': enable,
    };

    await _channel.invokeMethod('enableTcfMonitor', values);
  }

  static Future<bool> get exists async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    return await _channel.invokeMethod<bool>('exists') ?? false;
  }

  static Future<bool?> get isGranted async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;
    return await _channel.invokeMethod<bool>('isGranted');
  }

  static Future<bool?> request({bool withOptOut = false}) async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;

    Map<String, dynamic> values = {
      'withOptOut': withOptOut,
    };

    return await _channel.invokeMethod<bool>('request', values);
  }

  static Future<bool?> requestOnce({bool withOptOut = false}) async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;

    Map<String, dynamic> values = {
      'withOptOut': withOptOut,
    };

    return await _channel.invokeMethod<bool>('requestOnce', values);
  }

  static Future<void> set(bool granted) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    Map<String, dynamic> values = {
      'granted': granted,
    };

    await _channel.invokeMethod('set', values);
  }

  static Future<void> setIabString(String value) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    Map<String, dynamic> values = {
      'value': value,
    };

    await _channel.invokeMethod('setIabString', values);
  }
}
