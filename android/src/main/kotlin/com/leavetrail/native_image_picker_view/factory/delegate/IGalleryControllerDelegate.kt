package com.leavetrail.native_image_picker_view.factory.delegate

import android.view.View
import io.flutter.plugin.common.MethodChannel
import java.util.ArrayList

interface IGalleryControllerDelegate {

     fun onSelectionChange(args: ArrayList<*>?, result: MethodChannel.Result)
     fun updateOptions(args: ArrayList<*>?, result: MethodChannel.Result)
     fun getSelectedMediaList(args: ArrayList<*>?, result: MethodChannel.Result)
     fun selectAll(args: ArrayList<*>?, result: MethodChannel.Result)
     fun selectNone(args: ArrayList<*>?, result: MethodChannel.Result)
     fun reloadAlbum(args: ArrayList<*>?, result: MethodChannel.Result)
     fun getAlbumList(args: ArrayList<*>?, result: MethodChannel.Result)
     fun getView(): View
}