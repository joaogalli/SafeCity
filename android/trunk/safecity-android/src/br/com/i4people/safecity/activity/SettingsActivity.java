package br.com.i4people.safecity.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.persistence.shared.ContatoDao;
import br.com.i4people.safecity.persistence.shared.EmergenciaDao;
import br.com.i4people.safecity.persistence.shared.ContatoDao.Contato;

/**
 * @author joaoeduardogalli
 * 
 */
public class SettingsActivity extends Activity {

	private static final String TAG = "SettingsActivity";

	private static final int EDICAO_CONTATO = 1;

	private static final int EDICAO_EMERGENCIA = 2;

	private TextView contato1, contato2, contato3, emergencia;

	private ContatoDao contatoDao;

	private EmergenciaDao emergenciaDao;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.settings);

		contato1 = (TextView) findViewById(R.id.settings_contato1_preview);
		contato2 = (TextView) findViewById(R.id.settings_contato2_preview);
		contato3 = (TextView) findViewById(R.id.settings_contato3_preview);
		emergencia = (TextView) findViewById(R.id.settings_emergencia_preview);

		contatoDao = new ContatoDao(this);
		emergenciaDao = new EmergenciaDao(this);

		updateComponents();
	}

	private void updateComponents() {
		contato1.setText(contatoDao.getPreviewForContato(Contato.CONTATO1));
		contato2.setText(contatoDao.getPreviewForContato(Contato.CONTATO2));
		contato3.setText(contatoDao.getPreviewForContato(Contato.CONTATO3));
		emergencia.setText(emergenciaDao.getEmergencia());
	}

	public void onClick(View view) {
		Log.d(TAG, "Clicou em: " + view.getId());

		if (view.getId() == R.id.settings_contato1) {
			editContato(Contato.CONTATO1);
		}
		else if (view.getId() == R.id.settings_contato2) {
			editContato(Contato.CONTATO2);
		}
		else if (view.getId() == R.id.settings_contato3) {
			editContato(Contato.CONTATO3);
		}
		else if (view.getId() == R.id.settings_emergencia) {
			editEmergencia();
		}

	}

	private void editEmergencia() {
		Intent intent = new Intent(this, EmergenciaEdicaoActivity.class);
		startActivityForResult(intent, EDICAO_EMERGENCIA);
	}

	private void editContato(Contato contato) {
		Intent intent = new Intent(this, ContatoEdicaoActivity.class);
		intent.putExtra(ContatoEdicaoActivity.CONTATO, contato.name());
		startActivityForResult(intent, EDICAO_CONTATO);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case EDICAO_CONTATO:
			if (resultCode == RESULT_OK) {
				updateComponents();
			}

			break;

		case EDICAO_EMERGENCIA:
			if (resultCode == RESULT_OK) {
				updateComponents();
			}

			break;
		}
	}

}
