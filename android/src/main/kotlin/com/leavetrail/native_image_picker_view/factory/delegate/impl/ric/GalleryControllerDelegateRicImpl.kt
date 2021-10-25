package com.leavetrail.native_image_picker_view.factory.delegate.impl.ric

import android.view.View
import com.leavetrail.native_image_picker_view.factory.delegate.IGalleryControllerDelegate
import io.flutter.plugin.common.MethodChannel
import java.util.*
import java.util.concurrent.ExecutionException


class GalleryControllerDelegateRicImpl : IGalleryControllerDelegate {
    override fun onSelectionChange(args: ArrayList<*>?, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }

    override fun updateOptions(args: ArrayList<*>?, result: MethodChannel.Result) {
        setMaxImage(args,result)
        result.success(true)
    }

    override fun getSelectedMediaList(args: ArrayList<*>?, result: MethodChannel.Result) {
        val imageIdList: MutableList<Map<String, String>> = java.util.ArrayList()
        var i = 0
        while (i < adapter.selectedImages.size()) {
            val data: MediaData = adapter.selectedImages.get(i)

            //this will be implemented later
//                    String newPath = copyAndResizeFile(data.getAssetId());
            val map: MutableMap<String, String> = HashMap()
            map["type"] = data.getType().toString()
            map["albumId"] = data.getAlbumId()
            map["assetId"] = data.getAssetId()
            map["uri"] = data.getUri().toString()
            if (data is VideoData) {
                map["duration"] = java.lang.String.valueOf((data as VideoData).duration)
            }
            imageIdList.add(map)
            i++
        }
        result.success(imageIdList)
    }

    override fun selectAll(args: ArrayList<*>?, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }

    override fun selectNone(args: ArrayList<*>?, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }

    override fun reloadAlbum(args: ArrayList<*>?, result: MethodChannel.Result) {
        if (args is HashMap<*, *>) {
            val params = args as Map<String, Any>
            albumId = params["albumId"].toString()
            if (params["types"] != null) {
                val typesRaw = params["types"].toString()
                types = Arrays.asList(*typesRaw.split("-").toTypedArray())
            }
        }
        if (checkPermission()) {
            var bucketId: Long = 0
            try {
                bucketId = albumId.toLong()
            } catch (ignored: Exception) {
            }
            this.setAdapter(arrayOf<MediaData>())
            try {
                com.ric.image_list.DisplayImage(context, this, bucketId, true, types).execute().get()
            } catch (e: ExecutionException) {
                e.printStackTrace()
            } catch (e: InterruptedException) {
                e.printStackTrace()
            }
        }
        result.success(true)
    }

    override fun getAlbumList(args: ArrayList<*>?, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }

    override fun getView(): View {
        TODO("Not yet implemented")
    }

    private fun setMaxImage(args: ArrayList<*>?, result: MethodChannel.Result){
        if (args is HashMap<*, *>) {
            val params = args as Map<String, Any>
            maxImage = if (params["maxImage"] == null) null else Integer.valueOf(params["maxImage"].toString())
            adapter.setMaxSelected(maxImage)
            adapter.notifyDataSetChanged()
        }

    }
}