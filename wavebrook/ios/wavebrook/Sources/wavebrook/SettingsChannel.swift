import Flutter
import WavebrookCore

final class SettingsChannel: NSObject, FlutterPlugin {

    static let channelSettings = "\(WavebrookFlutterPlugin.channelMain)/settings"


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel  = FlutterMethodChannel(name: channelSettings, binaryMessenger: registrar.messenger())
        let instance = SettingsChannel()

        registrar.addMethodCallDelegate(instance, channel: channel)
    }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

        case "getBackgroundLocationEnabled":
            result(nil)

        case "isBackgroundLocationEnabled":
            result(false)

        case "setBackgroundLocationEnabled":
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
