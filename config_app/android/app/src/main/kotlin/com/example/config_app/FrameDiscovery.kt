package com.example.config_app

import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.net.wifi.WifiManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import java.net.Inet4Address
import java.util.ArrayDeque
import android.util.Log

private enum class DiscoveryMessage(val wireName: String) {
    STARTED("started"), RESOLVED("resolved"), LOST("lost"), LIMITED("limited"), RESOLVE_FAILED("resolveFailed")
}

class FrameDiscovery(private val context: Context) : EventChannel.StreamHandler {
    private var session: DiscoverySession? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        session?.close()
        session = DiscoverySession(context, events).also { it.start() }
    }

    override fun onCancel(arguments: Any?) {
        val previous = session
        session = null
        previous?.close()
    }

    fun dispose() = onCancel(null)
}

@Suppress("DEPRECATION")
private class DiscoverySession(context: Context, events: EventChannel.EventSink) {
    private val manager = context.getSystemService(Context.NSD_SERVICE) as NsdManager
    private val wifi = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
    private val handler = Handler(Looper.getMainLooper())
    private var sink: EventChannel.EventSink? = events
    private var discovery: NsdManager.DiscoveryListener? = null
    private var resolving: NsdManager.ResolveListener? = null
    private var multicast: WifiManager.MulticastLock? = null
    private val services = mutableMapOf<String, NsdServiceInfo>()
    private val pending = ArrayDeque<NsdServiceInfo>()

    private fun key(info: NsdServiceInfo) = info.serviceName
    private fun emit(type: DiscoveryMessage, fields: Map<String, Any> = emptyMap()) {
        sink?.success(mapOf("type" to type.wireName) + fields)
    }
    private fun callback(action: () -> Unit) {
        handler.post { if (sink != null) action() }
    }

    fun start() {
        try {
            if (Build.VERSION.SDK_INT < 34 && wifi != null) {
                val lock = wifi.createMulticastLock("DSlideshowDiscovery")
                lock.setReferenceCounted(false)
                lock.acquire()
                multicast = lock
            }
            val listener = object : NsdManager.DiscoveryListener {
                override fun onDiscoveryStarted(type: String) = callback { emit(DiscoveryMessage.STARTED) }
                override fun onDiscoveryStopped(type: String) = Unit
                override fun onStartDiscoveryFailed(type: String, code: Int) = callback {
                    discovery = null
                    sink?.error("discovery_start_$code", "Android NSD discovery failed", null)
                }
                override fun onStopDiscoveryFailed(type: String, code: Int) = callback {
                    sink?.error("discovery_stop_$code", "Android NSD stop failed", null)
                }
                override fun onServiceFound(info: NsdServiceInfo) = callback {
                    if (services.containsKey(key(info))) return@callback
                    if (services.size >= 256) {
                        emit(DiscoveryMessage.LIMITED)
                    } else {
                        services[key(info)] = info
                        pending.add(info)
                        resolveNext()
                    }
                }
                override fun onServiceLost(info: NsdServiceInfo) = callback {
                    services.remove(key(info))
                    pending.removeAll { key(it) == key(info) }
                    emit(DiscoveryMessage.LOST, mapOf("serviceKey" to key(info)))
                }
            }
            manager.discoverServices("_dslideshow._tcp.", NsdManager.PROTOCOL_DNS_SD, listener)
            discovery = listener
        } catch (error: Exception) {
            sink?.error("discovery_${error.javaClass.simpleName}", "Android NSD is unavailable", null)
        }
    }

    private fun resolveNext() {
        if (resolving != null || pending.isEmpty() || sink == null) return
        val info = pending.removeFirst()
        val listener = object : NsdManager.ResolveListener {
            override fun onResolveFailed(service: NsdServiceInfo, code: Int) = callback {
                resolving = null
                if (services[key(info)] === info) emit(DiscoveryMessage.RESOLVE_FAILED)
                resolveNext()
            }
            override fun onServiceResolved(service: NsdServiceInfo) = callback {
                resolving = null
                if (services[key(info)] === info) {
                    val address = if (Build.VERSION.SDK_INT >= 34) {
                        service.hostAddresses.filterIsInstance<Inet4Address>().firstOrNull()?.hostAddress
                    } else {
                        (service.host as? Inet4Address)?.hostAddress
                    }
                    if (address == null || service.port !in 1..65535) {
                        emit(DiscoveryMessage.RESOLVE_FAILED)
                    } else {
                        emit(DiscoveryMessage.RESOLVED, mapOf(
                            "serviceKey" to key(info), "hostname" to service.serviceName,
                            "address" to address, "port" to service.port
                        ))
                    }
                }
                resolveNext()
            }
        }
        resolving = listener
        try {
            manager.resolveService(info, listener)
        } catch (error: Exception) {
            resolving = null
            emit(DiscoveryMessage.RESOLVE_FAILED)
            resolveNext()
        }
    }

    fun close() {
        sink = null
        pending.clear()
        services.clear()
        discovery?.let {
            try { manager.stopServiceDiscovery(it) } catch (_: IllegalArgumentException) { }
            catch (error: Exception) { Log.w("AndroidDiscovery", "Discovery cleanup failed type=${error.javaClass.simpleName}") }
        }
        discovery = null
        if (Build.VERSION.SDK_INT >= 34) {
            resolving?.let {
                try { manager.stopServiceResolution(it) } catch (_: IllegalArgumentException) { }
                catch (error: Exception) { Log.w("AndroidDiscovery", "Resolver cleanup failed type=${error.javaClass.simpleName}") }
            }
        }
        resolving = null
        multicast?.release()
        multicast = null
    }
}
