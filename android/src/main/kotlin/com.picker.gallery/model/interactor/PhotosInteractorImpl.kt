package com.picker.gallery.model.interactor

import android.provider.MediaStore
import com.picker.gallery.model.GalleryAlbums
import com.picker.gallery.model.GalleryData
import com.picker.gallery.presenter.MediaPresenter
import com.picker.gallery.utils.MLog
import java.io.File
import kotlin.collections.ArrayList

class PhotosInteractorImpl(var presenter: MediaPresenter) : MediaInteractor {

    private fun getThumbnailPath(id: Long): String? {
        var result: String? = null
        val cursor = MediaStore.Images.Thumbnails.queryMiniThumbnail(presenter.contentResolver, id, MediaStore.Images.Thumbnails.MINI_KIND, null)
        if (cursor != null && cursor.count > 0) {
            cursor.moveToFirst()
            result = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Thumbnails.DATA))
            cursor.close()
        }
        return result
    }

    override fun getPhoneAlbums() {
        val galleryAlbums: ArrayList<GalleryAlbums> = ArrayList()
        val albumsNames: ArrayList<String> = ArrayList()

        val imagesProjection = arrayOf(MediaStore.Images.Media._ID, MediaStore.Images.Media.DATA, MediaStore.Images.Media.DATE_ADDED, MediaStore.Images.Media.TITLE)
        val imagesQueryUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val cursor = presenter.query(imagesQueryUri , imagesProjection);

        MLog.e("IMAGES", cursor.count.toString())

        try {
            if (cursor != null && cursor.count > 0) {
                if (cursor.moveToFirst()) {
                    val idColumn = cursor.getColumnIndex(MediaStore.Images.Media._ID)
                    val dataColumn = cursor.getColumnIndex(MediaStore.Images.Media.DATA)
                    val dateAddedColumn = cursor.getColumnIndex(MediaStore.Images.Media.DATE_ADDED)
                    val titleColumn = cursor.getColumnIndex(MediaStore.Images.Media.TITLE)
                    do {
                        val id = cursor.getString(idColumn)
                        val data = cursor.getString(dataColumn)
                        val dateAdded = cursor.getString(dateAddedColumn)
                        val title = cursor.getString(titleColumn)
                        val galleryData = GalleryData()
                        galleryData.albumName = File(data).parentFile.name
                        galleryData.photoUri = data
                        galleryData.id = Integer.valueOf(id)
                        galleryData.mediaType = MediaStore.Files.FileColumns.MEDIA_TYPE_IMAGE
                        galleryData.dateAdded = dateAdded
//                        galleryData.thumbnail = getThumbnailPath(galleryData.id.toLong()) ?: ""
//                        if (galleryData.thumbnail.isNotEmpty()) {
                            if (albumsNames.contains(galleryData.albumName)) {
                                for (album in galleryAlbums) {
                                    if (album.name == galleryData.albumName) {
                                        galleryData.albumId = album.id
                                        album.albumPhotos.add(galleryData)
                                        presenter.addGalleryData(galleryData)
                                        break
                                    }
                                }
                            } else {
                                val album = GalleryAlbums()
                                album.id = galleryData.id
                                galleryData.albumId = galleryData.id
                                album.name = galleryData.albumName
                                album.coverUri = galleryData.photoUri
                                album.albumPhotos.add(galleryData)
                                presenter.addGalleryData(galleryData)
                                galleryAlbums.add(album)
                                albumsNames.add(galleryData.albumName)
                            }
//                        }
                    } while (cursor.moveToNext())
                }
                cursor.close()
            } else presenter.onError()
        } catch (e: Exception) {
            MLog.e("IMAGE PICKER", e.toString())
        } finally {
            presenter.onComplete(galleryAlbums)
        }
    }

}