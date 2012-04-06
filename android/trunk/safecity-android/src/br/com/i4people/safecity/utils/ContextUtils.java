package br.com.i4people.safecity.utils;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

/**
 * @author joaoeduardogalli
 * 
 */
public abstract class ContextUtils {

	private static final String TAG = "ContextUtils";

	@SuppressWarnings("unchecked")
	public static <T> T getFromMetadata(Context context, String key, T defaultValue) {
		try {
			ApplicationInfo ai = context.getPackageManager().getApplicationInfo(context.getPackageName(),
					PackageManager.GET_META_DATA);
			Bundle bundle = ai.metaData;
			return (T) bundle.get(key);
		}
		catch (Exception e) {
			Log.e(TAG, "N‹o foi poss’vel capturar ApplicationInfo.", e);
			return defaultValue;
		}
	}

	public static <T> T getFromMetadata(Context context, int resource, T defaultValue) {
		return getFromMetadata(context, context.getString(resource), defaultValue);
	}

}
