import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channel = "com.example.flutter_application_aitoy/response"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channel, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "getHealthData":
                do {
                    let healthData = self?.generateMockHealthData()
                    result(healthData) // 确保只调用一次 result.success
                } catch {
                    result(FlutterError(code: "ERROR", message: "Failed to get health data", details: nil))
                }
            case "connectToDevice":
                do {
                    let isConnected = self?.simulateBluetoothConnection() ?? false
                    result(isConnected ? 1 : 0)
                } catch {
                    result(FlutterError(code: "ERROR", message: "Failed to connect to device", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func generateMockHealthData() -> [String: Any] {
        return [
            "status": 0,
            "totalSteps": 1000,
            "totalHeat": 200,
            "totalDistance": 5000,
            "totalSleep": 360,
            "totalDeepSleep": 180,
            "totalLightSleep": 180,
            "currentHeartRate": 75,
            "currentBloodOxygen": 98,
            "currentPressure": 120,
            "currentTemp": 36.5
        ]
    }

    private func simulateBluetoothConnection() -> Bool {
        return Bool.random()
    }
}
