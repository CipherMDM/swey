import 'dart:async';

import 'package:flutter/services.dart';

class PermissionsHandler {
  static const MethodChannel _channel = const MethodChannel("com.Cipher");

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> isWriteSettings() async {
    final bool isPermitted = await _channel.invokeMethod('isWriteSettings');
    return isPermitted;
  }

  static getWriteSettings() async {
    await _channel.invokeMethod('getWriteSettings');
  }

  static Future<bool> isUsageSettings() async {
    final bool isPermitted = await _channel.invokeMethod('isUsageSettings');
    return isPermitted;
  }

  static getUsageSettings() async {
    await _channel.invokeMethod('getUsageSettings');
  }

  static Future<bool> isDrawSettings() async {
    final bool isPermitted = await _channel.invokeMethod('isDrawSettings');
    return isPermitted;
  }

  static getDrawSettings() async {
    await _channel.invokeMethod('getDrawSettings');
  }

  static Future<bool> currentLauncher() async {
    final bool launcher = await _channel.invokeMethod('currentLauncher');
    return launcher;
  }

  static setLauncher() async {
    await _channel.invokeMethod('setLauncher');
  }
}
