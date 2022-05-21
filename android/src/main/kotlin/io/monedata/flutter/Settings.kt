package io.monedata.flutter

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.monedata.Settings
import io.monedata.flutter.MonedataFlutterPlugin.Companion.CHANNEL_MAIN

class Settings : FlutterPlugin, MethodCallHandler {

    private lateinit var channel : MethodChannel

    private lateinit var context: Context


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        channel = MethodChannel(binding.binaryMessenger, CHANNEL_SETTINGS)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            "getBackgroundLocationEnabled" -> result.success(Settings.getBackgroundLocationEnabled(context))

            "isBackgroundLocationEnabled"  -> result.success(Settings.isBackgroundLocationEnabled(context))

            "setBackgroundLocationEnabled" -> setBackgroundLocationEnabled(call, result)

            else                           -> result.notImplemented()
        }
    }


    private fun setBackgroundLocationEnabled(call: MethodCall, result: Result) {
        val enable = call.argument<Boolean>("enable")

        Settings.setBackgroundLocationEnabled(context, enable)

        result.success(null)
    }


    companion object {
        const val CHANNEL_SETTINGS = "${CHANNEL_MAIN}/settings"
    }
}