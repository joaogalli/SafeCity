package br.com.i4people.safecity.utils;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;

/**
 * @author joaoeduardogalli
 *
 */
public abstract class CallUtils {

	public static void makeCall(Activity activity, String telefone) {
		Intent intent = new Intent(Intent.ACTION_CALL);
		intent.setData(Uri.parse("tel:" + telefone));
		
		activity.startActivity(intent);
	}
	
}
