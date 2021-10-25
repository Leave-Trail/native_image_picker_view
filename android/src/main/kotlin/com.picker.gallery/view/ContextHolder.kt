package com.picker.gallery.view

import android.content.Context
import com.picker.gallery.model.GalleryData
import java.util.ArrayList

interface ContextHolder {

    abstract var ctx:Context;
    abstract var photoList: ArrayList<GalleryData>
    abstract var listener: OnPhoneImagesObtained

}
