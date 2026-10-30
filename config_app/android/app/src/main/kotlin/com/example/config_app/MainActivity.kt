package com.example.config_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import android.content.Intent

class MainActivity : FlutterActivity() {
    private var discovery: FrameDiscovery? = null
    private var discoveryChannel: EventChannel? = null
    private var documents: DocumentAccess? = null
    private var documentChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        discovery = FrameDiscovery(this)
        discoveryChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "dslideshow/frame_discovery").also {
            it.setStreamHandler(discovery)
        }
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        documents = DocumentAccess(this)
        documentChannel = MethodChannel(messenger, "dslideshow/documents").also { it.setMethodCallHandler(documents) }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        documents?.onActivityResult(requestCode, resultCode, data)
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        discovery?.dispose()
        discovery = null
        discoveryChannel?.setStreamHandler(null)
        discoveryChannel = null
        documentChannel?.setMethodCallHandler(null)
        documentChannel = null
        documents?.dispose()
        documents = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
