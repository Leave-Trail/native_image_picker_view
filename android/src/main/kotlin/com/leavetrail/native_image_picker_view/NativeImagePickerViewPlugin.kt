package com.leavetrail.native_image_picker_view

import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import com.leavetrail.native_image_picker_view.factory.GalleryFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter

private val VIEW_TYPE = "leavetrails.com/native_image_picker"

/** NativeImagePickerViewPlugin */
class NativeImagePickerViewPlugin: FlutterPlugin, ActivityAware {


    private var lifecycle: Lifecycle? = null



  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(binding.binaryMessenger, "native_image_picker_view")
//    channel.setMethodCallHandler(this)
    binding
            .platformViewRegistry
            .registerViewFactory(
                    VIEW_TYPE,
                    GalleryFactory(
                            binding.binaryMessenger,
                            lifecycle
                    ))
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
      lifecycle = null
  }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
