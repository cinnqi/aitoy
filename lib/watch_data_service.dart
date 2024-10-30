import 'package:flutter/services.dart';

class WatchDataService {
  static const platform = MethodChannel('com.example.flutter_application_aitoy/response');

  Future<Map<String, dynamic>?> getResponse() async {
    try {
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getResponse');
      // 将 Map<dynamic, dynamic> 转换为 Map<String, dynamic>
      return result?.map((key, value) => MapEntry(key.toString(), value));
    } on PlatformException catch (e) {
      print("Failed to get response: '${e.message}'.");
      return null;
    }
  }
}
