import Flutter
import WavebrookCore

public class WavebrookFlutterPlugin: NSObject, FlutterPlugin {

    static let channelMain = "wavebrook"


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel  = FlutterMethodChannel(name: channelMain, binaryMessenger: registrar.messenger())
        let instance = WavebrookFlutterPlugin()

        registrar.addMethodCallDelegate(instance, channel: channel)

        ConsentManagerChannel.register(with: registrar)
        SettingsChannel.register(with: registrar)
    }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]

        switch call.method {

        case "clearUserData":
            Wavebrook.clearUserData()
            result(nil)

        case "disableAdapter":
            disableAdapter(arguments, result)

        case "enableBackgroundLocation":
            result(nil)

        case "foundAdapters":
            result(Wavebrook.foundAdapters)

        case "getVersionName":
            result(Wavebrook.versionName)

        case "initialize":
            initialize(arguments, result)

        case "isInitialized":
            result(Wavebrook.isInitialized)

        case "isReady":
            result(Wavebrook.isReady)

        case "isStarted":
            result(Wavebrook.isStarted)

        case "start":
            Wavebrook.start()
            result(nil)

        case "startAdaptersActivity":
            result(false)

        case "stop":
            Wavebrook.stop()
            result(nil)

        case "waitForInitialization":
            Wavebrook.wait(forInitialization: { ready in
                result(ready)
            })

        default:
            result(FlutterMethodNotImplemented)
        }
    }


    private func disableAdapter(_ arguments: [String: Any]?, _ result: @escaping FlutterResult) {
        guard let disable = arguments?["disable"] as? Bool else {
            return result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing required argument: disable", details: nil))
        }

        guard let id = arguments?["id"] as? String else {
            return result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing required argument: id", details: nil))
        }

        Wavebrook.disableAdapter(id, disabled: disable)

        result(nil)
    }

    private func initialize(_ arguments: [String: Any]?, _ result: @escaping FlutterResult) {
        guard let assetKey = arguments?["assetKey"] as? String, !assetKey.isEmpty else {
            return result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing required argument: assetKey", details: nil))
        }

        let start = arguments?["start"] as? Bool ?? true

        Wavebrook.initialize(assetKey: assetKey, start: start) { success in
            result(success)
        }
    }
}
