package com.leavetrail.native_image_picker_view.factory

import android.content.Context
import androidx.lifecycle.Lifecycle
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class GalleryFactory(private val binaryMessenger: BinaryMessenger, private val lifecycle: Lifecycle?) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        val params = args as Map<String, Any>

        val builder:GalleryFactoryBuilder = GalleryFactoryBuilder();

        return builder.build(id,context,binaryMessenger,lifecycle);

    }

}
