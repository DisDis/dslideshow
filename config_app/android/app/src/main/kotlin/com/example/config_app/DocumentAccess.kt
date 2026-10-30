package com.example.config_app

import android.app.Activity
import android.content.Intent
import android.database.Cursor
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.DocumentsContract
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.InputStream
import java.util.concurrent.Executors
import android.util.Log

class DocumentAccess(private val activity: Activity) : MethodChannel.MethodCallHandler {
    companion object { const val REQUEST_DIRECTORY = 7041 }
    private val resolver = activity.contentResolver
    private val handler = Handler(Looper.getMainLooper())
    private val worker = Executors.newSingleThreadExecutor()
    private var selection: MethodChannel.Result? = null
    private var nextHandle = 0
    private val directories = mutableMapOf<Int, Pair<Uri, Cursor>>()
    private val readers = mutableMapOf<Int, InputStream>()
    private val columns = arrayOf(
        DocumentsContract.Document.COLUMN_DOCUMENT_ID,
        DocumentsContract.Document.COLUMN_DISPLAY_NAME,
        DocumentsContract.Document.COLUMN_MIME_TYPE,
        DocumentsContract.Document.COLUMN_SIZE
    )

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        worker.execute { execute(call, result) }
    }

    private fun execute(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "pickDirectory" -> handler.post {
                    if (activity.isFinishing || activity.isDestroyed) {
                        result.success(null)
                    } else if (selection != null) {
                        result.error("picker_busy", "A directory selection is already open", null)
                    } else {
                        selection = result
                        try {
                            activity.startActivityForResult(Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
                                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_PREFIX_URI_PERMISSION)
                            }, REQUEST_DIRECTORY)
                        } catch (error: Exception) {
                            selection = null
                            result.error("picker_${error.javaClass.simpleName}", "Directory picker failed", null)
                        }
                    }
                }
                "describe" -> {
                    val uri = Uri.parse(call.argument<String>("uri")!!)
                    resolver.query(uri, columns, null, null, null).use { cursor ->
                        if (cursor == null || !cursor.moveToFirst()) throw java.io.FileNotFoundException()
                        result.success(describe(uri, cursor))
                    }
                }
                "openDirectory" -> {
                    val uri = Uri.parse(call.argument<String>("uri")!!)
                    val children = DocumentsContract.buildChildDocumentsUriUsingTree(uri, DocumentsContract.getDocumentId(uri))
                    val cursor = resolver.query(children, columns, null, null, null)
                        ?: throw java.io.FileNotFoundException()
                    val handle = ++nextHandle
                    directories[handle] = Pair(uri, cursor)
                    result.success(handle)
                }
                "readDirectory" -> {
                    val (uri, cursor) = directories.getValue(call.argument<Int>("handle")!!)
                    val entries = mutableListOf<Map<String, Any?>>()
                    while (entries.size < 128 && cursor.moveToNext()) {
                        val child = DocumentsContract.buildDocumentUriUsingTree(uri, cursor.getString(0))
                        entries.add(describe(child, cursor))
                    }
                    result.success(entries)
                }
                "closeDirectory" -> {
                    directories.remove(call.argument<Int>("handle")!!)?.second?.close()
                    result.success(null)
                }
                "openRead" -> {
                    val stream = resolver.openInputStream(Uri.parse(call.argument<String>("uri")!!))
                        ?: throw java.io.FileNotFoundException()
                    val handle = ++nextHandle
                    readers[handle] = stream
                    result.success(handle)
                }
                "readChunk" -> {
                    val buffer = ByteArray(64 * 1024)
                    val length = readers.getValue(call.argument<Int>("handle")!!).read(buffer)
                    result.success(if (length < 0) null else buffer.copyOf(length))
                }
                "closeRead" -> {
                    readers.remove(call.argument<Int>("handle")!!)?.close()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        } catch (error: Exception) {
            result.error("documents_${error.javaClass.simpleName}", "Document access failed", null)
        }
    }

    private fun describe(uri: Uri, cursor: Cursor): Map<String, Any?> = mapOf(
        "uri" to uri.toString(), "name" to cursor.getString(1),
        "directory" to (cursor.getString(2) == DocumentsContract.Document.MIME_TYPE_DIR),
        "size" to if (cursor.isNull(3)) null else cursor.getLong(3)
    )

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != REQUEST_DIRECTORY) return
        val result = selection ?: return
        selection = null
        val tree = data?.data
        result.success(if (resultCode == Activity.RESULT_OK && tree != null) {
            DocumentsContract.buildDocumentUriUsingTree(tree, DocumentsContract.getTreeDocumentId(tree)).toString()
        } else null)
    }

    fun dispose() {
        selection?.success(null)
        selection = null
        worker.execute {
            directories.values.forEach {
                try { it.second.close() } catch (error: Exception) {
                    Log.w("AndroidDocuments", "Cursor cleanup failed type=${error.javaClass.simpleName}")
                }
            }
            directories.clear()
            readers.values.forEach {
                try { it.close() } catch (error: Exception) {
                    Log.w("AndroidDocuments", "Reader cleanup failed type=${error.javaClass.simpleName}")
                }
            }
            readers.clear()
        }
        worker.shutdown()
    }
}
