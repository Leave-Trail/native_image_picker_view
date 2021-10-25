package com.leavetrail.native_image_picker_view.model

import android.net.Uri

enum class MediaType {
    VIDEO, IMAGE
}

open class MediaData(val type: MediaType, val uri: Uri, val albumId: String, val assetId: String) {


}