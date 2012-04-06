package br.com.i4people.safecity.activity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;
import java.util.Set;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import br.com.i4people.safecity.BairroDetailActivity;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.model.Bairro;

/**
 * @author joaoeduardogalli
 * 
 */
public class DicaActivity extends Activity {

	private static final String TAG = "DicaActivity";

	private Bundle bairroBundle;

	private TextView labelView;

	private TextView descriptionView;

	private Map<Bairro, String> dicas;

	private ListIterator<Bairro> dicaKeys;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		try {
			bairroBundle = getIntent().getExtras().getBundle(BairroDetailActivity.BAIRRO);
		}
		catch (NullPointerException e) {
			this.finish();
		}

		setContentView(R.layout.dica);
		labelView = (TextView) this.findViewById(R.id.dica_label);
		descriptionView = (TextView) this.findViewById(R.id.dica_description);

		dicas = new HashMap<Bairro, String>(4);

		identifyDicas();

		if (dicas.isEmpty()) {
			this.finish();
		}
		else {
			showNextDica();
		}
	}

	private void showNextDica() {
		if (dicaKeys.hasNext()) {
			int index = dicaKeys.nextIndex();
			Bairro next = dicaKeys.next();

			labelView.setText(getString(R.string.dica_label, (index + 1)));
			descriptionView.setText(dicas.get(next));
		}
		else {
			dicaKeys = new LinkedList<Bairro>(dicas.keySet()).listIterator();
			showNextDica();
		}
	}

	private void identifyDicas() {
		dicas.put(Bairro.DICA1, "");
		dicas.put(Bairro.DICA2, "");
		dicas.put(Bairro.DICA3, "");
		dicas.put(Bairro.DICA4, "");

		Set<Bairro> keySet = new HashSet<Bairro>(dicas.keySet());
		for (Bairro bairro : keySet) {
			String dica = bairroBundle.getString(bairro.getId());
			if (dica == null || "".equals(dica)) {
				dicas.remove(bairro);
			}
			else {
				dicas.put(bairro, dica);
			}
		}

		dicaKeys = new LinkedList<Bairro>(dicas.keySet()).listIterator();
	}

	public void onClick(View v) {
		if (v.getId() == R.id.dica_nextDica) {
			showNextDica();
		}
	}

}
