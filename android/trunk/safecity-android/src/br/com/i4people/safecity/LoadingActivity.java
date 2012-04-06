package br.com.i4people.safecity;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.graphics.drawable.AnimationDrawable;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.ImageView;
import br.com.i4people.safecity.activity.BairroListaActivity;
import br.com.i4people.safecity.command.http.FindBairroByLocationTask;
import br.com.i4people.safecity.factory.city.AbstractCityFactory;
import br.com.i4people.safecity.factory.city.CityFactory;
import br.com.i4people.safecity.utils.ContextUtils;
import br.com.i4people.safecity.utils.FormatterUtils;

/**
 * @author joaoeduardogalli
 * 
 */
public class LoadingActivity extends Activity implements Runnable, LocationListener {

	private static final String TAG = "LoadingActivity";

	private LocationManager locationManager;

	private Double latitude, longitude, lastBestAccuracy;

	private Integer LOADING_TIMEOUT;

	private Double DESIRED_ACCURACY;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.loading);

		configureCityResources();

		startLoadingAnimation();

		activateLocationManager();

		LOADING_TIMEOUT = ContextUtils.getFromMetadata(this, R.string.meta_loading_timeout, 15000);
		DESIRED_ACCURACY = new Double((Integer) ContextUtils.getFromMetadata(this, R.string.meta_desired_accuracy, 200));

		Handler h = new Handler();
		h.postDelayed(this, LOADING_TIMEOUT);
	}

	private void startLoadingAnimation() {
		ImageView loadingImage = (ImageView) findViewById(R.id.loadingimage);
		loadingImage.setBackgroundResource(R.drawable.loading_animation);

		((AnimationDrawable) loadingImage.getBackground()).start();
	}

	private void configureCityResources() {
		CityFactory cityFactory = AbstractCityFactory.getCityFactory(this);

		setImageResource(R.id.loading_backgroundImage, cityFactory.getLoadingBackgroundResource());
		setImageResource(R.id.loading_cityname, cityFactory.getLoadingCityNameResource());
		setImageResource(R.id.loading_localizandotext, cityFactory.getLoadingLocalizandoResource());
	}

	private void setImageResource(int imageViewResource, int imageResource) {
		ImageView imageView = (ImageView) findViewById(imageViewResource);
		imageView.setImageResource(imageResource);
	}

	private void activateLocationManager() {
		Log.i(TAG, "Activating Location Manager");

		lastBestAccuracy = 99999d;
		latitude = null;
		longitude = null;

		locationManager = (LocationManager) this.getSystemService(Context.LOCATION_SERVICE);

		if (locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)) {
			locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, this);
		}
		else if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
			locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);
		}
		else {
			AlertDialog.Builder builder = new AlertDialog.Builder(this);
			builder.setTitle("Localização falhou").setMessage("Verifique se o GPS está ligado.");
			builder.setNeutralButton("Fechar", new OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {
					finish();
				}
			});
			builder.create().show();
		}
	}

	@Override
	public void run() {
		Log.i(TAG, "Desired Accuracy: " + DESIRED_ACCURACY +  " - Last Best: " + lastBestAccuracy);
		
		if (lastBestAccuracy < DESIRED_ACCURACY.doubleValue()) {
			locationManager.removeUpdates(this);

			FindBairroByLocationTask task = new FindBairroByLocationTask(this) {
				@Override
				protected void onPostExecute(Response result) {
					Log.i(TAG, "TASK onPostExecute: " + result.progress);
					switch (result.progress) {
					case BAD_RESPONSE:
						onBadResponseStatusCode(getLatitude(), getLongitude());
						break;

					case BAIRRO_NOT_FOUND:
						onBairroNotFound(getLatitude(), getLongitude());
						break;

					case SUCCESS:
						onSuccess(getLatitude(), getLongitude(), result.bairro);
						break;
					}
				}
			};

			// TODO passar coordenadas locais
			// Mock para vila Mariana: "-23.5997", "-46.6322"
			task.execute(Double.toString(latitude), Double.toString(longitude));
		}
		else {
			Log.w(TAG, "Post delayed.");
			Handler h = new Handler();
			h.postDelayed(this, LOADING_TIMEOUT);
		}
	}

	@Override
	public void onLocationChanged(Location location) {
		Log.i(TAG,
				FormatterUtils.format("Location received with Lat: %1$s, Long: %2$s and Accuracy: %3$s",
						location.getLatitude(), location.getLongitude(), location.getAccuracy()));

		if (location != null && (lastBestAccuracy == null || (lastBestAccuracy.floatValue() >= location.getAccuracy()))) {
			Log.i(TAG, "New location accepted.");
			lastBestAccuracy = (double) location.getAccuracy();
			latitude = location.getLatitude();
			longitude = location.getLongitude();
		}
	}

	@Override
	public void onProviderDisabled(String arg0) {
		Log.i(TAG, "Provider Disabled");
	}

	@Override
	public void onProviderEnabled(String arg0) {
		Log.i(TAG, "Provider Enabled");
	}

	@Override
	public void onStatusChanged(String arg0, int arg1, Bundle arg2) {
		Log.i(TAG, "Status changed");
	}

	public void onSuccess(String latitude, String longitude, Bundle bairro) {
		// Chama o BairroActivity

		Intent intent = new Intent(this, BairroDetailActivity.class);
		intent.putExtra(BairroDetailActivity.BAIRRO, bairro);
		this.startActivity(intent);
	}

	public void onBairroNotFound(String latitude, String longitude) {
		AlertDialog.Builder b = new AlertDialog.Builder(this);
		b.setTitle(R.string.title_bairro);
		b.setMessage(R.string.message_bairro_nao_encontrado);
		b.setCancelable(false);
		b.setPositiveButton(R.string.ver_lista_de_bairros, new OnClickListener() {
			@Override
			public void onClick(DialogInterface dialog, int which) {
				showBairrosLista();
			}
		});
		b.create().show();
	}

	protected void showBairrosLista() {
		Intent intent = new Intent(this, BairroListaActivity.class);
		this.startActivity(intent);
	}

	public void onBadResponseStatusCode(String latitude, String longitude) {
		AlertDialog.Builder b = new AlertDialog.Builder(this);
		b.setTitle(R.string.title_problema);
		b.setMessage(R.string.message_problema_servidor);
		b.setCancelable(false);
		b.setPositiveButton(R.string.ver_lista_de_bairros, new OnClickListener() {
			@Override
			public void onClick(DialogInterface dialog, int which) {
				showBairrosLista();
			}
		});
		b.create().show();
	}

}
