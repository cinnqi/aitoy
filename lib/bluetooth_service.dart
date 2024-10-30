import 'package:flutter/services.dart';

class BluetoothService {
  static const platform = MethodChannel('com.example.flutter_application_aitoy/response');

  // 模拟蓝牙连接，成功返回1，失败返回0
  Future<int> connectToDevice() async {
    try {
      final int result = await platform.invokeMethod('connectToDevice');
      return result;
    } on PlatformException catch (e) {
      print("Failed to connect to device: '${e.message}'.");
      return 0; // 连接失败时返回0
    }
  }

  Future<Map<String, dynamic>?> getHealthData() async {
    try {
      print("Attempting to fetch health data...");
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getHealthData');
      print("Health data received: $result");
      return result?.map((key, value) => MapEntry(key.toString(), value));
    } on PlatformException catch (e) {
      print("Failed to get health data: '${e.message}'.");
      return null;
    }
  }

}
