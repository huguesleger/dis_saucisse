package fr.huguesleger.dis_saucisse_mobile

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Handler
import android.os.Looper
import androidx.exifinterface.media.ExifInterface
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayInputStream
import java.io.File
import java.util.concurrent.Executors

class HeicConverter(private val cacheDir: File) : MethodChannel.MethodCallHandler {
    private val executor = Executors.newSingleThreadExecutor()
    private val mainThread = Handler(Looper.getMainLooper())

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val heic = call.argument<ByteArray>("bytes")
        val quality = call.argument<Double>("quality")
        if (call.method != "toJpeg" || heic == null || quality == null) {
            result.notImplemented()
            return
        }
        executor.execute {
            val jpeg = runCatching { toJpeg(heic, (quality * 100).toInt()) }.getOrNull()
            mainThread.post {
                if (jpeg != null) {
                    result.success(jpeg)
                } else {
                    result.error("conversion_failed", "HEIC could not be converted", null)
                }
            }
        }
    }

    private fun toJpeg(heic: ByteArray, quality: Int): ByteArray? {
        val bitmap = BitmapFactory.decodeByteArray(heic, 0, heic.size) ?: return null
        val output = File.createTempFile("heic", ".jpg", cacheDir)
        try {
            output.outputStream().use { bitmap.compress(Bitmap.CompressFormat.JPEG, quality, it) }
            bitmap.recycle()
            val source = ExifInterface(ByteArrayInputStream(heic))
            val target = ExifInterface(output)
            copiedTags.forEach { tag -> source.getAttribute(tag)?.let { target.setAttribute(tag, it) } }
            target.saveAttributes()
            return output.readBytes()
        } finally {
            output.delete()
        }
    }

    private companion object {
        val copiedTags = listOf(
            ExifInterface.TAG_DATETIME_ORIGINAL,
            ExifInterface.TAG_DATETIME_DIGITIZED,
            ExifInterface.TAG_DATETIME,
            ExifInterface.TAG_OFFSET_TIME_ORIGINAL,
            ExifInterface.TAG_OFFSET_TIME,
            ExifInterface.TAG_SUBSEC_TIME_ORIGINAL,
            ExifInterface.TAG_ORIENTATION,
            ExifInterface.TAG_MAKE,
            ExifInterface.TAG_MODEL,
            ExifInterface.TAG_EXPOSURE_TIME,
            ExifInterface.TAG_F_NUMBER,
            ExifInterface.TAG_PHOTOGRAPHIC_SENSITIVITY,
            ExifInterface.TAG_FOCAL_LENGTH,
            ExifInterface.TAG_GPS_LATITUDE,
            ExifInterface.TAG_GPS_LATITUDE_REF,
            ExifInterface.TAG_GPS_LONGITUDE,
            ExifInterface.TAG_GPS_LONGITUDE_REF,
            ExifInterface.TAG_GPS_ALTITUDE,
            ExifInterface.TAG_GPS_ALTITUDE_REF,
            ExifInterface.TAG_GPS_DATESTAMP,
            ExifInterface.TAG_GPS_TIMESTAMP,
        )
    }
}
