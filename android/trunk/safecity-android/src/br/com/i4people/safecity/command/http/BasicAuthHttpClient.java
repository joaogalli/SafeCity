package br.com.i4people.safecity.command.http;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.params.HttpClientParams;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;

public class BasicAuthHttpClient {

	private final int timeout;

	private final String password;

	private final String username;

	private DefaultHttpClient httpClient;

	public BasicAuthHttpClient(String username, String password, int timeout) {
		this.username = username;
		this.password = password;
		this.timeout = timeout;
	}

	public HttpResponse execute(HttpUriRequest request) {
		httpClient = new DefaultHttpClient();

		CredentialsProvider credProvider = new BasicCredentialsProvider();
		credProvider.setCredentials(new AuthScope(AuthScope.ANY_HOST, AuthScope.ANY_PORT),
				new UsernamePasswordCredentials(username, password));
		httpClient.setCredentialsProvider(credProvider);
		
		try {
			return httpClient.execute(request);
		}
		catch (ClientProtocolException e) {
			e.printStackTrace();
			return null;
		}
		catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}

	public void shutdown() {
		httpClient.getConnectionManager().shutdown();
	}

}
