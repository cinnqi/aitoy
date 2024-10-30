package com.example.flutter_application_aitoy

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

import com.starmax.bluetoothsdk.StarmaxMapResponse
import com.starmax.bluetoothsdk.data.NotifyType
import kotlin.random.Random

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter_application_aitoy/response"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getHealthData" -> {
                    try {
                        val healthData = generateMockHealthData()
                        result.success(healthData) // 确保只调用一次 result.success
                    } catch (e: Exception) {
                        result.error("ERROR", "Failed to get health data", e.message)
                    }
                }
                "connectToDevice" -> {
                    try {
                        val isConnected = simulateBluetoothConnection()
                        result.success(if (isConnected) 1 else 0)
                    } catch (e: Exception) {
                        result.error("ERROR", "Failed to connect to device", e.message)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun generateMockHealthData(): Map<String, Any> {
        return mapOf(
            "status" to 0,
            "totalSteps" to 1000,
            "totalHeat" to 200,
            "totalDistance" to 5000,
            "totalSleep" to 360,
            "totalDeepSleep" to 180,
            "totalLightSleep" to 180,
            "currentHeartRate" to 75,
            "currentBloodOxygen" to 98,
            "currentPressure" to 120,
            "currentTemp" to 36.5
        )
    }

    private fun simulateBluetoothConnection(): Boolean {
        return kotlin.random.Random.nextBoolean()
    }
}
