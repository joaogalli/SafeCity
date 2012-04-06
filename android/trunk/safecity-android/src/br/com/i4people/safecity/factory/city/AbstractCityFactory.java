package br.com.i4people.safecity.factory.city;

import android.content.Context;
import android.util.Log;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.factory.city.impl.RjCityFactory;
import br.com.i4people.safecity.factory.city.impl.SpCityFactory;
import br.com.i4people.safecity.utils.ContextUtils;

/**
 * @author joaoeduardogalli
 * 
 */
public abstract class AbstractCityFactory {

	private static final String TAG = "AbstractCityFactory";

	/**
	 * @param context
	 * @return The CityFactory correspondent to the city.
	 */
	public static CityFactory getCityFactory(Context context) throws IllegalArgumentException {
		String city = ContextUtils.getFromMetadata(context, R.string.meta_city, "sp");

		Log.i(TAG, "City: " + city);

		if ("sp".equals(city)) {
			return new SpCityFactory();
		}
		else if ("rj".equals(city)) {
			return new RjCityFactory();
		}

		throw new IllegalArgumentException("Cidade n‹o encontrada: " + city);
	}

}
