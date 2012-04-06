package br.com.i4people.safecity.utils;

import java.io.IOException;
import java.io.InputStream;

import org.apache.http.HttpEntity;

/**
 * @author joaoeduardogalli
 * 
 */
public abstract class HttpUtils {

	public static String toString(HttpEntity entity) throws IllegalStateException, IOException {
		return HttpUtils.toString(entity.getContent());
	}

	public static String toString(InputStream content) throws IOException {
		StringBuilder sb = new StringBuilder();
		int b = -1;

		while ((b = content.read()) != -1) {
			sb.append((char) b);
		}

		return sb.toString();
	}

}
