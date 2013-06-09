package br.com.i4people.safecity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;
import android.widget.TextView;
import br.com.i4people.safecity.activity.AlertaEspecialActivity;
import br.com.i4people.safecity.activity.BairroListaActivity;
import br.com.i4people.safecity.activity.DicaActivity;
import br.com.i4people.safecity.component.Toolbar;
import br.com.i4people.safecity.model.Bairro;
import br.com.i4people.safecity.persistence.shared.EmergenciaDao;
import br.com.i4people.safecity.utils.CallUtils;

/**
 * @author joaoeduardogalli
 *
 */
public class BairroDetailActivity extends Activity {

	private static final String TAG = "BairroDetailActivity";
	
	public static final String BAIRRO = "bairro";

	private Bundle bairroBundle;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.bairrodetail);
		
		bairroBundle = getIntent().getExtras().getBundle(BAIRRO);
		
		TextView anuncie = (TextView) findViewById(R.id.bairroDetail_anuncieAqui);
		anuncie.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				CallUtils.makeCall(BairroDetailActivity.this, "01135964736");
			}
		});
		
		Toolbar toolbar = (Toolbar) this.findViewById(R.id.bairroDetail_toolbar);
		toolbar.setBairro(bairroBundle);
		
		EditText nomeBairroEditText = (EditText) findViewById(R.id.bairrodetail_bairroText);
		nomeBairroEditText.setText(bairroBundle.getString(Bairro.NOME.getId()));
		
		EditText ocorrencia1EditText = (EditText) findViewById(R.id.bairrodetail_ocorrencia1);
		ocorrencia1EditText.setText(bairroBundle.getString(Bairro.DELITO1.getId()));
		
		EditText ocorrencia2EditText = (EditText) findViewById(R.id.bairrodetail_ocorrencia2);
		ocorrencia2EditText.setText(bairroBundle.getString(Bairro.DELITO2.getId()));
	}

	public void buttonsClick(View view) {
		if (view.getId() == R.id.bairroDetail_dicasButton) {
			Log.i(TAG, "Clicou em Dicas");
			startActivityWithBairroAsBundle(DicaActivity.class);
		}
		else if (view.getId() == R.id.bairroDetail_alertaEspecialButton) {
			Log.i(TAG, "Clicou em Alerta");
			startActivityWithBairroAsBundle(AlertaEspecialActivity.class);
		}
		else if (view.getId() == R.id.bairroDetail_emergenciaButton) {
			Log.i(TAG, "Clicou em Emergencia");
			EmergenciaDao emergenciaDao = new EmergenciaDao(this);
			CallUtils.makeCall(this, emergenciaDao.getEmergencia());
		}
		else if (view.getId() == R.id.bairroDetail_meuDestinoButton) {
			Log.i(TAG, "Clicou em Meu Destino");
			Intent bairroListaIntent = new Intent(this, BairroListaActivity.class);
			this.startActivity(bairroListaIntent);
		}
	}
	
	public void startActivityWithBairroAsBundle(Class<?> klass) {
		Intent intent = new Intent(this, klass);
		intent.putExtra(BAIRRO, bairroBundle);
		
		startActivity(intent);
	}
	
	public void anuncieAquiCall(View view) {
		Log.d(TAG, "anuncieAqui");
		if (view.getId() == R.id.bairroDetail_anuncieAqui) {
			
		}
	}
	
}
