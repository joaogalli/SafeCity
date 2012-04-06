package br.com.i4people.safecity.model;

import java.text.ParseException;

import org.json.JSONException;
import org.json.JSONObject;

import android.os.Bundle;
import android.util.Log;

/**
 * @author joaoeduardogalli
 *
 */
public enum Bairro {

	NOME("nome"),
	ZONA("zona"),
	DELITO1("delito1"),
	DELITO2("delito2"),
	ALERTA_ESPECIAL("alertaEspecial"),
	DICA1("dica1"),
	DICA2("dica2"),
	DICA3("dica3"),
	DICA4("dica4"),
	DELEGACIA_ENDERECO1("delegaciaEndereco1"),
	DELEGACIA_TELEFONE1("delegaciaTelefone1"),
	DELEGACIA_ENDERECO2("delegaciaEndereco2"),
	DELEGACIA_TELEFONE2("delegaciaTelefone2"),
	HOSPITAL_ENDERECO1("hospitalEndereco1"),
	HOSPITAL_TELEFONE1("hospitalTelefone1"),
	HOSPITAL_ENDERECO2("hospitalEndereco2"),
	HOSPITAL_TELEFONE2("hospitalTelefone2"),
	HOSPITAL_ENDERECO3("hospitalEndereco3"),
	HOSPITAL_TELEFONE3("hospitalTelefone3"),
	CIDADE("cidade"),
	CERCA("cerca");
	
	String id;
	
	private Bairro(String id) {
		this.id = id;
	}

	public static Bundle parseJson(String responseBody) throws ParseException, JSONException {
		Bundle bundle = new Bundle();
		
		String TAG = "Bairro";
		
		JSONObject obj = new JSONObject(responseBody);
		Log.i(TAG, "Length: " + obj.length());
		
		Bairro[] values = Bairro.values();
		for (Bairro bairro : values) {
			try {
				String campo = obj.getString(bairro.id);
				if ("null".equals(campo)) {
					campo = null;
				}
				
				bundle.putString(bairro.id, campo);
			} catch (Exception e) {
				Log.e(TAG, "Error getting: " + bairro.id);
			}
		}
		
		return bundle;
	}

	public String getId() {
		return id;
	}

	public static Bairro getTelefoneFor(Bairro bairro) {
		switch (bairro) {
		case DELEGACIA_ENDERECO1:
			return DELEGACIA_TELEFONE1;
		case DELEGACIA_ENDERECO2:
			return DELEGACIA_TELEFONE2;
		case HOSPITAL_ENDERECO1:
			return HOSPITAL_TELEFONE1;
		case HOSPITAL_ENDERECO2:
			return HOSPITAL_TELEFONE2;
		case HOSPITAL_ENDERECO3:
			return HOSPITAL_TELEFONE3;
		}

		return null;
	}

}
