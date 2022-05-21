import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'network.dart';

class Monedata {
  static const CHANNEL_MAIN = "monedata";

  static const MethodChannel _channel = const MethodChannel(CHANNEL_MAIN);

  static Future<void> disableNetwork(Network network, bool value) async {
    String? name = describeEnum(network);

    Map<String, dynamic> values = {
      'network': name,
      'value': value,
    };

    await _channel.invokeMethod('disableNetwork', values);
  }

  static Future<void> enableBackgroundLocation(bool? enable) async {
    Map<String, dynamic> values = {
      'enable': enable,
    };

    await _channel.invokeMethod('enableBackgroundLocation', values);
  }

  static Future<List<String>> get foundAdapters async {
    return await _channel.invokeMethod('foundAdapters');
  }

  static Future<bool> initialize(String assetKey, {bool start = true}) async {
    Map<String, dynamic> values = {
      'assetKey': assetKey,
      'start': start,
    };

    return await _channel.invokeMethod('initialize', values);
  }

  static Future<bool> get isInitialized async {
    return await _channel.invokeMethod('isInitialized');
  }

  static Future<bool> get isReady async {
    return await _channel.invokeMethod('isReady');
  }

  static Future<bool> get isStarted async {
    return await _channel.invokeMethod('isStarted');
  }

  static Future<void> start() async {
    await _channel.invokeMethod('start');
  }

  static Future<bool> startAdaptersActivity() async {
    return await _channel.invokeMethod('startAdaptersActivity');
  }

  static Future<void> stop() async {
    await _channel.invokeMethod('stop');
  }

  static Future<String> get versionName async {
    return await _channel.invokeMethod('getVersionName');
  }

  static Future<bool> waitForInitialization() async {
    return await _channel.invokeMethod('waitForInitialization');
  }
}
