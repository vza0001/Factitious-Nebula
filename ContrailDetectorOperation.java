package net.ddns.ritesh.contrails;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ImageView;

import java.lang.ref.WeakReference;
import java.util.Vector;

/**
 * Created by Ritesh
 */
public class ContrailDetectorOperation extends AsyncTask<Bitmap, Void, Bitmap> {

    private final WeakReference<ImageView> imageViewReference;
    private final AppCompatActivity _activity;
    public ContrailDetectorOperation(ImageView imageView,
                                     AppCompatActivity contrails) {
        imageViewReference = new WeakReference<ImageView>(imageView);
        _activity = contrails;
    }

    // Run algorithm in background.
    @Override
    protected Bitmap doInBackground(Bitmap... params) {
        Bitmap bitmap = params[0];
        int imageWidth = bitmap.getWidth();
        int imageHeight = bitmap.getHeight();
        Vector<Integer> allPixels = new Vector<>();

        for(int i = 0 ; i < imageWidth; ++i) {
            for(int j = 0; j < imageHeight; ++j) {
                int pixel = bitmap.getPixel(i, j);
                allPixels.add(pixel);

            }
        }

        //TODO -- Plugin the algorithm to determine whether the cloud is a contrail or not
        boolean isContrail = false;
        Bitmap result = null;
        if(isContrail)
            result = BitmapFactory.decodeResource(_activity.getResources(), R.drawable.yes);
        else
            result = BitmapFactory.decodeResource(_activity.getResources(), R.drawable.no);
        
        return result;
    }

    // Once complete, see if ImageView is still around and set bitmap.
    @Override
    protected void onPostExecute(Bitmap bitmap) {
        if (imageViewReference != null && bitmap != null) {
            final ImageView imageView = imageViewReference.get();
            if (imageView != null) {
                imageView.setImageBitmap(bitmap);
            }
        }
    }
}
