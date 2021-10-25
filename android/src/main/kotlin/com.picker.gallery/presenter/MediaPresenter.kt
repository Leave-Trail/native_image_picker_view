package com.picker.gallery.presenter

import android.content.ContentResolver
import android.database.Cursor
import android.net.Uri
import com.picker.gallery.model.GalleryAlbums
import com.picker.gallery.model.GalleryData

interface MediaPresenter {
    abstract val contentResolver: ContentResolver?
    fun getPhoneAlbums()
    fun onError()
    fun onComplete(galleryAlbums: ArrayList<GalleryAlbums>)
    fun addGalleryData(galleryData: GalleryData)
    fun query(imagesQueryUri: Uri, imagesProjection:Array<String>): Cursor
}