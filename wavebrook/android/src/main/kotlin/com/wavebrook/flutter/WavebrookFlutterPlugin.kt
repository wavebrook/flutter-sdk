package com.wavebrook.flutter

import android.app.Activity
import android.content.Context
import com.wavebrook.Wavebrook
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class WavebrookFlutterPlugin : ActivityAware, FlutterPlugin, MethodCallHandler {

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

            "clearUserData"            -> clearUserData(result)

            "disableAdapter"           -> disableAdapter(call, result)

            "enableBackgroundLocation" -> enableBackgroundLocation(call, result)

            "foundAdapters"            -> result.success(Wavebrook.foundAdapters)

            "getVersionName"           -> result.success(Wavebrook.versionName)

            "initialize"               -> initialize(call, result)

            "isInitialized"            -> result.success(Wavebrook.isInitialized)

            "isReady"                  -> result.success(Wavebrook.isReady)

            "isStarted"                -> result.success(Wavebrook.isStarted)

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


    private fun clearUserData(result: Result) {
        Wavebrook.clearUserData(context)

        result.success(null)
    }

    private fun disableAdapter(call: MethodCall, result: Result) {
        val disable = call.argument<Boolean>("disable")
        val id      = call.argument<String> ("id")

        requireNotNull(disable)
        requireNotNull(id)

        Wavebrook.disableAdapter(context, id, disable)

        result.success(null)
    }

    private fun enableBackgroundLocation(call: MethodCall, result: Result) {
        val enable = call.argument<Boolean>("enable")

        Wavebrook.enableBackgroundLocation(context, enable)

        result.success(null)
    }

    private fun initialize(call: MethodCall, result: Result) {
        val assetKey = call.argument<String> ("assetKey")
        val start    = call.argument<Boolean>("start") ?: true

        require(!assetKey.isNullOrEmpty())

        Wavebrook.initialize(context, assetKey, start) {
            result.success(it)
        }
    }

    private fun start(result: Result) {
        Wavebrook.start(context)

        result.success(null)
    }

    private fun startAdaptersActivity(result: Result) {
        val success = activity?.let { Wavebrook.startAdaptersActivity(it) } == true

        result.success(success)
    }

    private fun stop(result: Result) {
        Wavebrook.stop(context)

        result.success(null)
    }

    private fun waitForInitialization(result: Result) {
        Wavebrook.waitForInitialization { 
            result.success(it)
        }
    }


    companion object {
        const val CHANNEL_MAIN = "wavebrook"
    }
}
