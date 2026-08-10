import Flutter
import WavebrookCore

final class ConsentManagerChannel: NSObject, FlutterPlugin {

    static let channelConsent = "\(WavebrookFlutterPlugin.channelMain)/consentManager"


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel  = FlutterMethodChannel(name: channelConsent, binaryMessenger: registrar.messenger())
        let instance = ConsentManagerChannel()

        registrar.addMethodCallDelegate(instance, channel: channel)
    }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]

        switch call.method {

        case "canCollectPersonalData":
            result(ConsentManager.shared.canCollectPersonalData)

        case "enableTcfMonitor":
            enableTcfMonitor(arguments, result)

        case "exists":
            result(ConsentManager.shared.exists)

        case "get":
            result(ConsentManager.shared.current.map(toMap))

        case "isGranted":
            result(ConsentManager.shared.isGranted)

        case "request", "requestOnce":
            result(nil)

        case "set":
            set(arguments, result)

        case "setIabString":
            setIabString(arguments, result)

        default:
            result(FlutterMethodNotImplemented)
        }
    }


    private func enableTcfMonitor(_ arguments: [String: Any]?, _ result: @escaping FlutterResult) {
        guard let enable = arguments?["enable"] as? Bool else {
            return result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing required argument: enable", details: nil))
        }

        ConsentManager.shared.tcfMonitorEnabled = enable

        result(nil)
    }

    private func set(_ arguments: [String: Any]?, _ result: @escaping FlutterResult) {
        guard let granted = arguments?["granted"] as? Bool else {
            return result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing required argument: granted", details: nil))
        }

        ConsentManager.shared.set(granted: granted)

        result(nil)
    }

    private func setIabString(_ arguments: [String: Any]?, _ result: @escaping FlutterResult) {
        guard let value = arguments?["value"] as? String else {
            return result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing required argument: value", details: nil))
        }

        ConsentManager.shared.set(iabString: value)

        result(nil)
    }

    private func toMap(_ consent: ConsentData) -> [String: Any?] {
        [
            "date":      Int(consent.date.timeIntervalSince1970 * 1000),
            "granted":   consent.granted,
            "iabString": consent.iabString,
            "source":    consent.source?.rawValue.uppercased()
        ]
    }
}
