package br.com.i4people.safecity.activity;

import br.com.i4people.safecity.BairroDetailActivity;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.model.Bairro;
import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

/**
 * @author joaoeduardogalli
 *
 */
public class AlertaEspecialActivity extends Activity {
	
	private static final String TAG = "AlertaEspecialActivity";

	private Bundle bairroBundle;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		try {
			bairroBundle = getIntent().getExtras().getBundle(BairroDetailActivity.BAIRRO);
		} catch (NullPointerException e) {
			this.finish();
		}
		
		if (bairroBundle == null) {
			this.finish();
		}
		
		this.setContentView(R.layout.alerta_especial);
		
		TextView descriptionTextView = (TextView) findViewById(R.id.alerta_description);
		descriptionTextView.setText(bairroBundle.getString(Bairro.ALERTA_ESPECIAL.getId()));
	}
	
}
