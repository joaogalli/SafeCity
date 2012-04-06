package br.com.i4people.safecity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

/**
 * @author joaoeduardogalli
 *
 */
public class SplashScreenActivity extends Activity implements Runnable {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splashscreen);

		Handler h = new Handler();
		h.postDelayed(this, 3000);
	}

	@Override
	public void run() {
		startActivity(new Intent(this, LoadingActivity.class));
		finish();
	}
}