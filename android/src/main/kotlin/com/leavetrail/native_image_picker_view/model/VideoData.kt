package com.leavetrail.native_image_picker_view.model

import android.net.Uri

internal class VideoData(uri: Uri, albumId: String, assetId: String, val duration: Long) : MediaData(MediaType.VIDEO, uri, albumId, assetId)