package br.com.i4people.safecity.command.http;

import java.text.ParseException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.model.Bairro;
import br.com.i4people.safecity.utils.ContextUtils;
import br.com.i4people.safecity.utils.FormatterUtils;

/**
 * @author joaoeduardogalli
 * 
 */
@Deprecated
public class FindBairroByLocationCommand {

	private static final String TAG = "FindBairroByLocationCommand";

	public interface CommandCallBack {
		public void onSuccess(String latitude, String longitude, Bundle bairro);

		public void onBairroNotFound(String latitude, String longitude);

		public void onBadResponseStatusCode(String latitude, String longitude);
	}

	public void execute(Context context, final String latitude, final String longitude,
			final CommandCallBack callback) {
		String city = ContextUtils.getFromMetadata(context, R.string.meta_city, "sp");

		String host = ContextUtils.getFromMetadata(context, R.string.meta_host, "http://localhost:8080");
		String uri = host + "/SafeCity/bairroes/cerca/%1$s/%2$s/%3$s/t";
		uri = FormatterUtils.format(uri, latitude, longitude, city);

		Log.i(TAG, "URI: " + uri);

		String username = "iphone";
		String password = "iphoneSafeCity";
		int timeout = 30000;

		PreemptiveHttpClient httpClient = new PreemptiveHttpClient(username, password, timeout);

		try {
			HttpGet httpget = new HttpGet(uri);
			httpget.addHeader("Accept", "application/json");

			Log.i(TAG, "Executing: " + httpget.getRequestLine().toString());

			HttpResponse httpResponse = httpClient.execute(httpget);
			StatusLine statusLine = httpResponse.getStatusLine();
			Log.i(TAG, statusLine.getStatusCode() + " - " + statusLine.getReasonPhrase());

			if (200 != statusLine.getStatusCode()) {
				callback.onBadResponseStatusCode(latitude, longitude);
			}
			else {
				HttpEntity entity = httpResponse.getEntity();
				String responseBody = EntityUtils.toString(entity);

				Log.i(TAG, responseBody);
				if (responseBody == null || "".equals(responseBody)) {
					callback.onBairroNotFound(latitude, longitude);
				}
				else {
					try {
						callback.onSuccess(latitude, longitude, Bairro.parseJson(responseBody));
					}
					catch (ParseException e) {
						callback.onBairroNotFound(latitude, longitude);
					}
				}
			}
		}
		catch (Exception e) {
			Log.e(TAG, "Error", e);
		}
		finally {
			httpClient.shutdown();
		}

	}
}
