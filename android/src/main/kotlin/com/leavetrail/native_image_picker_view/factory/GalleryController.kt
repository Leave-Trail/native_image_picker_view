package com.leavetrail.native_image_picker_view.factory

import android.content.Context
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.Lifecycle
import com.leavetrail.native_image_picker_view.factory.delegate.IGalleryControllerDelegate
import com.leavetrail.native_image_picker_view.factory.delegate.impl.ric.GalleryControllerDelegateRicImpl
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import java.util.*
import java.util.concurrent.ExecutionException

class GalleryController(private val id: Int, private val context: Context, private val binaryMessenger: BinaryMessenger,private val lifecycle: Lifecycle?, options: GalleryOptions)
    : PlatformView, MethodCallHandler,DefaultLifecycleObserver {

    private val delegate: IGalleryControllerDelegate = GalleryControllerDelegateRicImpl();

    override fun getView(): View {
        return delegate.getView();
    }

    override fun dispose() {

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val args = call.arguments<ArrayList<*>>()
        when(call.method) {
            "gallery#waitForGallery" -> result.success(true)
            "media#onSelectionChanged" -> delegate.onSelectionChange(args,result)
            "picker#updateOptions" -> delegate.updateOptions(args, result)
            "album#getList" -> delegate.getAlbumList(args, result)
            "album#reload" -> delegate.reloadAlbum(args, result)
            "media#selectAll" -> delegate.selectAll(args, result)
            "media#selectNone" -> delegate.selectNone(args, result)
            "media#getSelected" -> delegate.getSelectedMediaList(args, result)
            else -> result.notImplemented()
        }

    }

}
