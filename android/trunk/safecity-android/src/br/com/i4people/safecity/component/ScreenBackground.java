package br.com.i4people.safecity.component;

import android.content.Context;
import android.util.AttributeSet;
import android.view.ViewGroup.LayoutParams;
import android.widget.ImageView;
import br.com.i4people.safecity.factory.city.AbstractCityFactory;
import br.com.i4people.safecity.factory.city.CityFactory;

/**
 * @author joaoeduardogalli
 * 
 */
public class ScreenBackground extends ImageView {

	private static final String TAG = "ScreenBackground";

	public ScreenBackground(Context context) {
		super(context);
		config();
	}

	public ScreenBackground(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		config();
	}

	public ScreenBackground(Context context, AttributeSet attrs) {
		super(context, attrs);
		config();
	}

	public void config() {
		this.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));

		CityFactory cityFactory = AbstractCityFactory.getCityFactory(getContext());

		this.setImageResource(cityFactory.getScreenBackgroundResource());
		this.setScaleType(ScaleType.CENTER_CROP);
	}

}
