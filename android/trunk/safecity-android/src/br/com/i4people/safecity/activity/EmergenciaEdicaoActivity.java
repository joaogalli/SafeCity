package br.com.i4people.safecity.activity;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.persistence.shared.EmergenciaDao;

/**
 * @author joaoeduardogalli
 *
 */
public class EmergenciaEdicaoActivity extends Activity {

	private static final String TAG = "ContatoEdicaoActivity";

	private EditText telefoneView;

	private EmergenciaDao emergenciaDao;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		this.setContentView(R.layout.emergencia_edicao);
		telefoneView = (EditText) this.findViewById(R.id.emergencia_edicao_telefone);
		
		emergenciaDao = new EmergenciaDao(this);
		String telefone = emergenciaDao.getEmergencia();
		
		telefoneView.setText(telefone);
	}
	
	public void onClick(View view) {
		if (view.getId() == R.id.emergencia_edicao_salvar) {
			String telefone = telefoneView.getText().toString();
			emergenciaDao.setEmergencia(telefone);
			this.setResult(RESULT_OK);
			this.finish();
		}
	}
	
}
