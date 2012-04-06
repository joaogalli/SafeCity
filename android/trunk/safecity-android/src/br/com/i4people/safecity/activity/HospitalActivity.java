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
public class HospitalActivity extends Activity {
	private static final String TAG = "HospitalActivity";

	private Bundle bairroBundle;
	
	private Map<Bairro, Hospital> items = new HashMap<Bairro, HospitalActivity.Hospital>();
	
	private ListIterator<Bairro> itemKeys;
	
	private LinearLayout telefoneLayout;
	
	private TextView labelView, descriptionView, telefoneView;
	
	private static class Hospital {
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
		
		this.setContentView(R.layout.hospital);
		labelView = (TextView) this.findViewById(R.id.hospital_label);
		descriptionView = (TextView) this.findViewById(R.id.hospital_description);
		telefoneView = (TextView) this.findViewById(R.id.hospital_telefone);
		telefoneLayout = (LinearLayout) this.findViewById(R.id.hospital_telefoneLayout);
		
		showNextItem();
	}
	
	private void showNextItem() {
		if (itemKeys.hasNext()) {
			int index = itemKeys.nextIndex();
			Bairro next = itemKeys.next();

			labelView.setText(getString(R.string.hospital_label, (index + 1)));
			
			Hospital hospital = items.get(next);
			descriptionView.setText(hospital.endereco);
			if (StringUtils.isEmpty(hospital.telefone)) {
				telefoneLayout.setVisibility(View.INVISIBLE);
				telefoneView.setText("");
			} else {
				telefoneLayout.setVisibility(View.VISIBLE);
				telefoneView.setText(hospital.telefone);
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
		items.put(Bairro.HOSPITAL_ENDERECO1, null);
		items.put(Bairro.HOSPITAL_ENDERECO2, null);
		items.put(Bairro.HOSPITAL_ENDERECO3, null);
		
		Set<Bairro> keySet = new HashSet<Bairro>(items.keySet());
		for (Bairro bairro : keySet) {
			String endereco = bairroBundle.getString(bairro.getId());
			
			if (StringUtils.isEmpty(endereco)) {
				items.remove(bairro);
			} else {
				Hospital hospital = new Hospital();
				hospital.endereco = endereco;
				hospital.telefone = bairroBundle.getString(Bairro.getTelefoneFor(bairro).getId());
				items.put(bairro, hospital);
			}
		}
		
		itemKeys = new LinkedList<Bairro>(items.keySet()).listIterator();
		
		return !items.isEmpty();
	}
	
	/**
	 * @param view
	 */
	public void onClick(View view) {
		if (view.getId() == R.id.hospital_ligarButton) {
			CallUtils.makeCall(this, telefoneView.getText().toString());
		}
		else if (view.getId() == R.id.hospital_nexthospital) {
			showNextItem();
		}
	}
}
