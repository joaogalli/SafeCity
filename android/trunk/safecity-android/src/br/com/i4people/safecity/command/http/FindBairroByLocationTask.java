package br.com.i4people.safecity.command.http;

import java.text.ParseException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.HttpGet;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.model.Bairro;
import br.com.i4people.safecity.utils.ContextUtils;
import br.com.i4people.safecity.utils.FormatterUtils;
import br.com.i4people.safecity.utils.HttpUtils;

/**
 * @author joaoeduardogalli
 * 
 */
public class FindBairroByLocationTask extends AsyncTask<String, Enum, FindBairroByLocationTask.Response> {

	private static final String TAG = "FindBairroByLocationTask";

	private final Context context;

	private String city, host, uri, username, password;

	private static final int timeout = 30000;

	private String latitude;

	private String longitude;

	public static class Response {
		public Progress progress;

		public Bundle bairro;

		public Response(Progress progress, Bundle bairro) {
			super();
			this.progress = progress;
			this.bairro = bairro;
		}
	}

	public static enum Progress {
		BAD_RESPONSE, BAIRRO_NOT_FOUND, SUCCESS, SYSTEM_ERROR;
	}
	
	public FindBairroByLocationTask(Context context) {
		this.context = context;
	}

	@Override
	protected void onPreExecute() {
		city = ContextUtils.getFromMetadata(context, R.string.meta_city, "--");

		host = ContextUtils.getFromMetadata(context, R.string.meta_host, "--");
		uri = host + "/SafeCity/bairroes/cerca/%1$s/%2$s/%3$s/t";

		Log.i(TAG, "URI: " + uri);

		username = "iphone";
		password = "iphoneSafeCity";
	}

	@Override
	protected Response doInBackground(String... params) {
		if (params.length != 2) {
			throw new IllegalArgumentException("Devem haver dois par‰meros: latitude e longitude.");
		}
		setLatitude(params[0]);
		setLongitude(params[1]);

		String connectionUri = FormatterUtils.format(uri, getLatitude(), getLongitude(), city);

		PreemptiveHttpClient httpClient = new PreemptiveHttpClient(username, password, timeout);

		try {
			HttpGet httpget = new HttpGet(connectionUri);
			httpget.addHeader("Accept", "application/json");

			Log.i(TAG, "Executing: " + httpget.getRequestLine().toString());

			HttpResponse httpResponse = httpClient.execute(httpget);
			StatusLine statusLine = httpResponse.getStatusLine();
			Log.i(TAG, statusLine.getStatusCode() + " - " + statusLine.getReasonPhrase());

			if (200 != statusLine.getStatusCode()) {
				return new Response(Progress.BAD_RESPONSE, null);
			}
			else {
				HttpEntity entity = httpResponse.getEntity();
				String responseBody = HttpUtils.toString(entity);

				Log.i(TAG, responseBody);
				
				if (responseBody == null || "".equals(responseBody)) {
					return new Response(Progress.BAIRRO_NOT_FOUND, null);
				}
				else {
					try {
						return new Response(Progress.SUCCESS, Bairro.parseJson(responseBody));
					}
					catch (ParseException e) {
						return new Response(Progress.BAIRRO_NOT_FOUND, null);
					}
				}
			}
		}
		catch (Exception e) {
			Log.e(TAG, "Error", e);
			return new Response(Progress.SYSTEM_ERROR, null);
		}
		finally {
			httpClient.shutdown();
		}
	}

	public String getLatitude() {
		return latitude;
	}

	protected void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	protected void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
}
