package br.com.i4people.safecity.activity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;
import java.util.Set;

import br.com.i4people.safecity.BairroDetailActivity;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.model.Bairro;
import br.com.i4people.safecity.utils.CallUtils;
import br.com.i4people.safecity.utils.StringUtils;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

/**
 * @author joaoeduardogalli
 *
 */
public class PoliciaActivity extends Activity {

	private static final String TAG = "PoliciaActivity";

	private Bundle bairroBundle;
	
	private Map<Bairro, Policia> items = new HashMap<Bairro, PoliciaActivity.Policia>();
	
	private ListIterator<Bairro> itemKeys;
	
	private LinearLayout telefoneLayout;
	
	private TextView labelView, descriptionView, telefoneView;
	
	private static class Policia {
		public String endereco, telefone;
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		try {
			bairroBundle = getIntent().getExtras().getBundle(BairroDetailActivity.BAIRRO);
			bairroBundle.size();
		}
		catch (NullPointerException e) {
			Log.e(TAG, "Erro ao capturar bairro bundle.", e);
			this.finish();
		}
		
		if (!identifyItems()) {
			Log.e(TAG, "N‹o foi identificado delegacias.");
			this.finish();
		}
		
		this.setContentView(R.layout.policia);
		labelView = (TextView) this.findViewById(R.id.policia_label);
		descriptionView = (TextView) this.findViewById(R.id.policia_description);
		telefoneView = (TextView) this.findViewById(R.id.policia_telefone);
		telefoneLayout = (LinearLayout) this.findViewById(R.id.policia_telefoneLayout);
		
		showNextItem();
	}
	
	private void showNextItem() {
		if (itemKeys.hasNext()) {
			int index = itemKeys.nextIndex();
			Bairro next = itemKeys.next();

			labelView.setText(getString(R.string.policia_label, (index + 1)));
			
			Policia policia = items.get(next);
			descriptionView.setText(policia.endereco);
			if (StringUtils.isEmpty(policia.telefone)) {
				telefoneLayout.setVisibility(View.INVISIBLE);
				telefoneView.setText("");
			} else {
				telefoneLayout.setVisibility(View.VISIBLE);
				telefoneView.setText(policia.telefone);
			}
			
		} else {
			itemKeys = new LinkedList<Bairro>(items.keySet()).listIterator();
			showNextItem();
		}
	}

	/**
	 * @return True se algum item foi identificado.
	 */
	private boolean identifyItems() {
		items.put(Bairro.DELEGACIA_ENDERECO1, null);
		items.put(Bairro.DELEGACIA_ENDERECO2, null);
		
		Set<Bairro> keySet = new HashSet<Bairro>(items.keySet());
		for (Bairro bairro : keySet) {
			String endereco = bairroBundle.getString(bairro.getId());
			if (endereco == null || "".equals(endereco)) {
				items.remove(bairro);
			} else {
				Policia policia = new Policia();
				policia.endereco = endereco;
				policia.telefone = bairroBundle.getString(Bairro.getTelefoneFor(bairro).getId());
				items.put(bairro, policia);
			}
		}
		
		itemKeys = new LinkedList<Bairro>(items.keySet()).listIterator();
		
		return !items.isEmpty();
	}
	
	/**
	 * @param view
	 */
	public void onClick(View view) {
		if (view.getId() == R.id.policia_ligarButton) {
			CallUtils.makeCall(this, telefoneView.getText().toString());
		}
		else if (view.getId() == R.id.policia_nextpolicia) {
			showNextItem();
		}
	}
	
}
