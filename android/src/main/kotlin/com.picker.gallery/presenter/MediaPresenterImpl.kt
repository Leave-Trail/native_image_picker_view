package com.picker.gallery.presenter

import android.content.ContentResolver
import android.database.Cursor
import android.net.Uri
import com.picker.gallery.model.GalleryAlbums
import com.picker.gallery.model.GalleryData
import com.picker.gallery.model.interactor.MediaInteractor
import com.picker.gallery.model.interactor.PhotosInteractorImpl
import com.picker.gallery.model.interactor.VideosInteractorImpl
import com.picker.gallery.view.ContextHolder
import com.picker.gallery.view.PhotosFragment

class MediaPresenterImpl(var photosFragment: ContextHolder, val type: String = "IMAGE"): MediaPresenter {
    private val interactor: MediaInteractor = when(type){
        "IMAGE" -> PhotosInteractorImpl(this)
        "VIDEO" -> VideosInteractorImpl(this)
        else -> throw Exception("Not implemented MediaInteractor for: " + type)
    }

    override val contentResolver = photosFragment.ctx.contentResolver

    override fun getPhoneAlbums() {
        interactor.getPhoneAlbums()
    }

    override fun onError() {
        this.photosFragment.listener.onError()
    }

    override fun onComplete(galleryAlbums: ArrayList<GalleryAlbums>) {
        this.photosFragment.listener.onComplete(galleryAlbums)
    }

    override fun addGalleryData(galleryData: GalleryData){
        this.photosFragment.photoList.add(galleryData)
    }
    override fun query(imagesQueryUri: Uri, imagesProjection:Array<String>): Cursor {
        return this.photosFragment.ctx.contentResolver.query(imagesQueryUri, imagesProjection, null, null, null);
    }


}