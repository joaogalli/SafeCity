package br.com.i4people.safecity.command.http;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.HttpRequestInterceptor;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScheme;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.AuthState;
import org.apache.http.auth.Credentials;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.ExecutionContext;
import org.apache.http.protocol.HttpContext;

/**
 * Wrapper of HttpClient that forces preemptive BASIC authentication if user
 * credentials exist.
 * 
 * @author Yossi Shaul
 */
public class PreemptiveHttpClient {

	private final static String CLIENT_VERSION;

	private DefaultHttpClient httpClient;

	private BasicHttpContext localContext;

	static {
		// initialize client version
		Properties properties = new Properties();
		InputStream is = PreemptiveHttpClient.class.getResourceAsStream("/bi.client.properties");
		if (is != null) {
			try {
				properties.load(is);
				is.close();
			}
			catch (IOException e) {
				// ignore, use the default value
			}
		}
		CLIENT_VERSION = properties.getProperty("client.version", "unknown");
	}

	public PreemptiveHttpClient(int timeout) {
		this(null, null, timeout);
	}

	public PreemptiveHttpClient(String userName, String password, int timeout) {
		httpClient = createHttpClient(userName, password, timeout);
	}

	public void setProxyConfiguration(String host, int port, String username, String password) {
		HttpHost proxy = new HttpHost(host, port);
		httpClient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY, proxy);
		if (username != null) {
			httpClient.getCredentialsProvider().setCredentials(new AuthScope(host, port),
					new UsernamePasswordCredentials(username, password));
		}
	}

	public HttpResponse execute(HttpUriRequest request) throws IOException {
		if (localContext != null) {
			return httpClient.execute(request, localContext);
		}
		else {
			return httpClient.execute(request);
		}
	}

	private DefaultHttpClient createHttpClient(String userName, String password, int timeout) {
		BasicHttpParams params = new BasicHttpParams();
		int timeoutMilliSeconds = timeout * 1000;
		HttpConnectionParams.setConnectionTimeout(params, timeoutMilliSeconds);
		HttpConnectionParams.setSoTimeout(params, timeoutMilliSeconds);
		DefaultHttpClient client = new DefaultHttpClient(params);

		if (userName != null && !"".equals(userName)) {
			client.getCredentialsProvider().setCredentials(AuthScope.ANY,
					new UsernamePasswordCredentials(userName, password));
			localContext = new BasicHttpContext();

			// Generate BASIC scheme object and stick it to the local execution
			// context
			BasicScheme basicAuth = new BasicScheme();
			localContext.setAttribute("preemptive-auth", basicAuth);

			// Add as the first request interceptor
			client.addRequestInterceptor(new PreemptiveAuth(), 0);
		}

		// set the following user agent with each request
		String userAgent = "ArtifactoryBuildClient/" + CLIENT_VERSION;
		HttpProtocolParams.setUserAgent(client.getParams(), userAgent);
		return client;
	}

	public void shutdown() {
		httpClient.getConnectionManager().shutdown();
	}

	public void setHttpParams(HttpParams httpParams) {
		httpClient.setParams(httpParams);
	}

	static class PreemptiveAuth implements HttpRequestInterceptor {
		public void process(final HttpRequest request, final HttpContext context) throws HttpException, IOException {

			AuthState authState = (AuthState) context.getAttribute(ClientContext.TARGET_AUTH_STATE);

			// If no auth scheme available yet, try to initialize it
			// preemptively
			if (authState.getAuthScheme() == null) {
				AuthScheme authScheme = (AuthScheme) context.getAttribute("preemptive-auth");
				CredentialsProvider credsProvider = (CredentialsProvider) context
						.getAttribute(ClientContext.CREDS_PROVIDER);
				HttpHost targetHost = (HttpHost) context.getAttribute(ExecutionContext.HTTP_TARGET_HOST);
				if (authScheme != null) {
					Credentials creds = credsProvider.getCredentials(new AuthScope(targetHost.getHostName(), targetHost
							.getPort()));
					if (creds == null) {
						throw new HttpException("No credentials for preemptive authentication");
					}
					authState.setAuthScheme(authScheme);
					authState.setCredentials(creds);
				}
			}
		}
	}
}
