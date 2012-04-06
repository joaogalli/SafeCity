package br.com.i4people.safecity.utils;

/**
 * @author joaoeduardogalli
 *
 */
public abstract class StringUtils {

	public static boolean isEmpty(String string) {
		return (string == null || string.length() == 0);
	}
	
}
