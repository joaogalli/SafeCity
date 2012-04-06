package br.com.i4people.safecity.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;
import br.com.i4people.safecity.BairroDetailActivity;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.command.http.FindAllBairrosTask;
import br.com.i4people.safecity.model.Bairro;

public class BairroListaActivity extends ListActivity {

	private static final String TAG = "BairroListaActivity";

	private static final int OPTION_UPDATE = 1;

	public static List<Bundle> bairros;

	private ProgressDialog progressDialog;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.bairro_lista);

		if (bairros == null || bairros.isEmpty())
			startLoading();
		else
			updateList(null);
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		menu.add(Menu.NONE, OPTION_UPDATE, 1, R.string.atualizar);
		
		return super.onCreateOptionsMenu(menu);
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case OPTION_UPDATE:
			startLoading();
			break;
		}
		
		return true;
	}

	private void startLoading() {
		bairros = null;
		
		progressDialog = ProgressDialog.show(this, "Aguarde", "Carregando Bairros...");

		new FindAllBairrosTask(this) {
			protected void onPostExecute(Response result) {
				if (result != null) {
					updateList(result.bairros);
				}
				else {
					Toast.makeText(BairroListaActivity.this, "N‹o foi poss’vel listar os bairros.", Toast.LENGTH_LONG)
							.show();
					BairroListaActivity.this.finish();
				}
			}
		}.execute("sp");
	}

	protected void updateList(List<Bundle> bairrosParam) {
		if (bairrosParam != null)
			BairroListaActivity.bairros = bairrosParam;

		List<String> list = new ArrayList<String>(bairros.size());

		for (int i = 0; i < bairros.size(); i++) {
			list.add(bairros.get(i).getString(Bairro.NOME.getId()));
		}

		ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.bairro_lista_item,
				R.id.bairro_lista_item_nome, list);
		this.setListAdapter(adapter);

		if (progressDialog != null) {
			progressDialog.dismiss();
		}
	}

	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);

		Bundle bairroId = this.bairros.get((int) id);
		Log.d(TAG, "Bairro from Position: " + bairroId.getString(Bairro.NOME.getId()));
		
		Intent intent = new Intent(this, BairroDetailActivity.class);
		intent.putExtra(BairroDetailActivity.BAIRRO, bairroId);
		this.startActivity(intent);
	}

}
