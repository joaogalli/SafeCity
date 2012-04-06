package br.com.i4people.safecity.activity;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.persistence.shared.ContatoDao;
import br.com.i4people.safecity.persistence.shared.ContatoDao.Contato;
import br.com.i4people.safecity.utils.CallUtils;

/**
 * @author joaoeduardogalli
 * 
 */
public class PersonalActivity extends Activity {

	private static final String TAG = "PersonalActivity";

	private ContatoDao contatoDao;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.personal);

		contatoDao = new ContatoDao(this);

		configure(Contato.CONTATO1, 1, R.id.personal_contato1_title, R.id.personal_text_contato1);
		configure(Contato.CONTATO2, 2, R.id.personal_contato2_title, R.id.personal_text_contato2);
		configure(Contato.CONTATO3, 3, R.id.personal_contato3_title, R.id.personal_text_contato3);
	}

	private void configure(Contato contato, int order, int titleId, int buttonId) {
		Bundle bundle = contatoDao.getContato(contato);

		String nome = bundle.getString(ContatoDao.NOME);
		String telefone = bundle.getString(ContatoDao.TELEFONE);

		((TextView) findViewById(titleId)).setText(getString(R.string.personal_contato_title, Integer.toString(order),
				nome));
		((TextView) findViewById(buttonId)).setText(getString(R.string.personal_contato_telefone, telefone));
	}

	public void onClick(View view) {
		if (view.getId() == R.id.personal_contato1) {
			ligarPara(Contato.CONTATO1);
		}
		else if (view.getId() == R.id.personal_contato2) {
			ligarPara(Contato.CONTATO2);
		}
		else if (view.getId() == R.id.personal_contato3) {
			ligarPara(Contato.CONTATO3);
		}
	}

	private void ligarPara(Contato contato) {
		try {
			Bundle bundle = contatoDao.getContato(contato);
			String telefone = bundle.getString(ContatoDao.TELEFONE);

			CallUtils.makeCall(this, telefone);
		}
		catch (Exception e) {
			Log.e(TAG, "Erro ao ligar.", e);
			Toast.makeText(this, "N‹o foi poss’vel ligar para o contato.", Toast.LENGTH_LONG).show();
		}
	}

}
