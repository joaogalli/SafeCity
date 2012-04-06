package br.com.i4people.safecity.utils;

import java.io.ByteArrayOutputStream;
import java.util.Formatter;


/**
 * @author joaoeduardogalli
 *
 */
public abstract class FormatterUtils {

	public static String format(String text, Object... os) {
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		
		Formatter f = new Formatter(stream);
		f.format(text, os);
		f.flush();
		f.close();
		
		return stream.toString();
	}
	
}
