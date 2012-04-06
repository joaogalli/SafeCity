package br.com.i4people.safecity.activity;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.persistence.shared.ContatoDao;
import br.com.i4people.safecity.persistence.shared.ContatoDao.Contato;

/**
 * @author joaoeduardogalli
 * 
 */
public class ContatoEdicaoActivity extends Activity {

	public static final String CONTATO = "contato";

	private static final String TAG = "ContatoEdicaoActivity";

	private TextView nomeView, telefoneView;

	private Contato contato;

	private ContatoDao contatoDao;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		if (getIntent() == null || getIntent().getStringExtra(CONTATO) == null) {
			this.setResult(RESULT_CANCELED);
			this.finish();
		}

		contato = Contato.valueOf(getIntent().getStringExtra(CONTATO));

		if (contato == null) {
			this.setResult(RESULT_CANCELED);
			this.finish();
		}

		contatoDao = new ContatoDao(this);
		Bundle bundle = contatoDao.getContato(contato);

		this.setContentView(R.layout.contato_edicao);
		nomeView = (TextView) findViewById(R.id.contato_edicao_nome);
		telefoneView = (TextView) findViewById(R.id.contato_edicao_telefone);

		nomeView.setText(bundle.getString(ContatoDao.NOME));
		telefoneView.setText(bundle.getString(ContatoDao.TELEFONE));
	}

	public void onClick(View view) {
		if (view.getId() == R.id.contato_edicao_salvar) {
			try {
				String nome = nomeView.getText().toString();
				String telefone = telefoneView.getText().toString();
				contatoDao.setContato(contato, nome, telefone);
				
				this.setResult(RESULT_OK);
				this.finish();
			}
			catch (Exception e) {
				Log.e(TAG, "Erro ao salvar contato.", e);
				this.setResult(RESULT_CANCELED);
				this.finish();
			}
		}
	}

}
