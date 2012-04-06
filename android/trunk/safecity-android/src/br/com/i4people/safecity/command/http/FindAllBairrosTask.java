package br.com.i4people.safecity.command.http;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.HttpGet;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.model.Bairro;
import br.com.i4people.safecity.utils.ContextUtils;
import br.com.i4people.safecity.utils.FormatterUtils;
import br.com.i4people.safecity.utils.HttpUtils;

public class FindAllBairrosTask extends AsyncTask<String, Enum, FindAllBairrosTask.Response> {

	private static final String TAG = "FindAllBairrosTask";

	private final Context context;

	private String city, host, uri, username, password;

	private static final int timeout = 30000;

	public static class Response {
		public Progress progress;

		public List<Bundle> bairros;

		public Response(Progress progress, List<Bundle> bairros) {
			super();
			this.progress = progress;
			this.bairros = bairros;
		}
	}

	public static enum Progress {
		BAD_RESPONSE, SUCCESS;
	}
	public FindAllBairrosTask(Context context) {
		this.context = context;
	}
	
	@Override
	protected void onPreExecute() {
		city = ContextUtils.getFromMetadata(context, R.string.meta_city, "--");

		host = ContextUtils.getFromMetadata(context, R.string.meta_host, "http://localhost:8080");
		uri = host + "/SafeCity/bairroes/all/%1$s";

		Log.i(TAG, "URI: " + uri);

		username = "iphone";
		password = "iphoneSafeCity";
	}
	
	@Override
	protected Response doInBackground(String... params) {
		String connectionUri = FormatterUtils.format(uri, city);

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
					return new Response(Progress.BAD_RESPONSE, null);
				}
				else {
					try {
						return new Response(Progress.SUCCESS, parseJson(responseBody));
					}
					catch (ParseException e) {
						return new Response(Progress.BAD_RESPONSE, null);
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

		return null;
	}

	private List<Bundle> parseJson(String responseBody) throws JSONException, ParseException {
		JSONTokener t = new JSONTokener(responseBody);
		
		JSONArray array = (JSONArray) t.nextValue();
		
		List<Bundle> bairros = new ArrayList<Bundle>(array.length());
		
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonObject = array.getJSONObject(i);
			String jsonString = jsonObject.toString();
			Log.d(TAG, jsonString);
			
			Bundle bairro = Bairro.parseJson(jsonString);
			
			bairros.add(bairro);
		}
		
		Collections.sort(bairros, new Comparator<Bundle>() {
			@Override
			public int compare(Bundle lhs, Bundle rhs) {
				String nome1 = lhs.getString(Bairro.NOME.getId());
				String nome2 = rhs.getString(Bairro.NOME.getId());
				
				return nome1.compareTo(nome2);
			}
		});
		
		return bairros;
	}

}
