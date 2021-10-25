package com.leavetrail.native_image_picker_view.factory

import android.content.Context
import androidx.lifecycle.Lifecycle
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

class GalleryFactoryBuilder {

    fun build(id: Int, context: Context?, binaryMessenger: BinaryMessenger, lifecycle: Lifecycle?): PlatformView {

        return GalleryController(id,context,binaryMessenger,lifecycle);
    }

}
