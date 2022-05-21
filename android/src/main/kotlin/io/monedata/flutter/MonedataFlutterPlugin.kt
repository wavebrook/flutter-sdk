package io.monedata.flutter

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.monedata.Monedata
import io.monedata.networks.Network

class MonedataFlutterPlugin : ActivityAware, FlutterPlugin, MethodCallHandler {

    private var activity: Activity? = null

    private val activityAwarePlugins: List<ActivityAware>
        get() = plugins.mapNotNull { it as? ActivityAware }

    private val plugins = listOf<FlutterPlugin>(
        ConsentManager(),
        Settings()
    )


    private lateinit var channel : MethodChannel

    private lateinit var context: Context


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity

        activityAwarePlugins.forEach { it.onAttachedToActivity(binding) }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        channel = MethodChannel(binding.binaryMessenger, CHANNEL_MAIN)
        channel.setMethodCallHandler(this)

        plugins.forEach { it.onAttachedToEngine(binding) }
    }

    override fun onDetachedFromActivity() {
        activity = null

        activityAwarePlugins.forEach { it.onDetachedFromActivity() }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null

        activityAwarePlugins.forEach { it.onDetachedFromActivityForConfigChanges() }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)

        plugins.forEach { it.onDetachedFromEngine(binding) }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            "disableNetwork"           -> disableNetwork(call, result)

            "enableBackgroundLocation" -> enableBackgroundLocation(call, result)

            "foundAdapters"            -> result.success(Monedata.foundAdapters)

            "getVersionName"           -> result.success(Monedata.versionName)

            "initialize"               -> initialize(call, result)

            "isInitialized"            -> result.success(Monedata.isInitialized)

            "isReady"                  -> result.success(Monedata.isReady)

            "isStarted"                -> result.success(Monedata.isStarted)

            "start"                    -> start(result)

            "startAdaptersActivity"    -> startAdaptersActivity(result)

            "stop"                     -> stop(result)

            "waitForInitialization"    -> waitForInitialization(result)

            else                       -> result.notImplemented()
        }
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityAwarePlugins.forEach { it.onReattachedToActivityForConfigChanges(binding) }
    }


    private fun disableNetwork(call: MethodCall, result: Result) {
        val networkId = call.argument<String> ("network")
        val value     = call.argument<Boolean>("value")

        requireNotNull(value)

        val network = Network.values().find { it.id == networkId }

        requireNotNull(network)

        Monedata.disableNetwork(context, network, value)

        result.success(null)
    }

    private fun enableBackgroundLocation(call: MethodCall, result: Result) {
        val enable = call.argument<Boolean>("enable")

        Monedata.enableBackgroundLocation(context, enable)

        result.success(null)
    }

    private fun initialize(call: MethodCall, result: Result) {
        val assetKey = call.argument<String> ("assetKey")
        val start    = call.argument<Boolean>("start") ?: true

        require(!assetKey.isNullOrEmpty())

        Monedata.initialize(context, assetKey, start) {
            result.success(it)
        }
    }

    private fun start(result: Result) {
        Monedata.start(context)

        result.success(null)
    }

    private fun startAdaptersActivity(result: Result) {
        val success = activity?.let { Monedata.startAdaptersActivity(it) } == true

        result.success(success)
    }

    private fun stop(result: Result) {
        Monedata.stop(context)

        result.success(null)
    }

    private fun waitForInitialization(result: Result) {
        Monedata.waitForInitialization { 
            result.success(it)
        }
    }


    companion object {
        const val CHANNEL_MAIN = "monedata"
    }
}
