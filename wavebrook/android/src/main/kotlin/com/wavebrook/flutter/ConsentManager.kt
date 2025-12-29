package com.wavebrook.flutter

import android.app.Activity
import android.content.Context
import com.wavebrook.consent.ConsentManager
import com.wavebrook.flutter.WavebrookFlutterPlugin.Companion.CHANNEL_MAIN
import com.wavebrook.flutter.extensions.toMap
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class ConsentManager : ActivityAware, FlutterPlugin, MethodCallHandler {

    private var activity: Activity? = null

    private lateinit var channel : MethodChannel

    private lateinit var context: Context


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        channel = MethodChannel(binding.binaryMessenger, CHANNEL_CONSENT)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            "canCollectPersonalData" -> result.success(ConsentManager.canCollectPersonalData(context))

            "enableTcfMonitor"       -> enableTcfMonitor(call, result)

            "exists"                 -> result.success(ConsentManager.exists(context))

            "isGranted"              -> result.success(ConsentManager.isGranted(context))

            "get"                    -> get(call, result)

            "request"                -> request(call, result)

            "requestOnce"            -> requestOnce(call, result)

            "set"                    -> set(call, result)

            "setIabString"           -> setIabString(call, result)

            else                     -> result.notImplemented()
        }
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }


    private fun enableTcfMonitor(call: MethodCall, result: Result) {
        val enable = call.argument<Boolean>("enable")

        requireNotNull(enable)

        ConsentManager.enableTcfMonitor(context, enable)

        result.success(null)
    }

    private fun get(call: MethodCall, result: Result) {
        val data = ConsentManager.get(context)

        result.success(data?.toMap())
    }

    private fun request(call: MethodCall, result: Result) {
        val activity = requireNotNull(activity)

        val withOptOut = call.argument<Boolean>("withOptOut") ?: false

        ConsentManager.request(activity, withOptOut) {
            result.success(it?.granted)
        }
    }

    private fun requestOnce(call: MethodCall, result: Result) {
        val activity = requireNotNull(activity)

        val withOptOut = call.argument<Boolean>("withOptOut") ?: false

        ConsentManager.requestOnce(activity, withOptOut) {
            result.success(it?.granted)
        }
    }

    private fun set(call: MethodCall, result: Result) {
        val granted = call.argument<Boolean>("granted")

        requireNotNull(granted)

        ConsentManager.set(context, granted)

        result.success(null)
    }

    private fun setIabString(call: MethodCall, result: Result) {
        val value = call.argument<String>("value")

        requireNotNull(value)

        ConsentManager.setIabString(context, value)

        result.success(null)
    }


    companion object {
        const val CHANNEL_CONSENT = "${CHANNEL_MAIN}/consentManager"
    }
}
