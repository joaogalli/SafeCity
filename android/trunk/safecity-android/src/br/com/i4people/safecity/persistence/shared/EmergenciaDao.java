package br.com.i4people.safecity.persistence.shared;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * @author joaoeduardogalli
 * 
 */
public class EmergenciaDao {

	private static final String FILE_NAME = "shared_emergencia";

	private static final String TELEFONE = "telefone";
	
	private final Context context;

	public EmergenciaDao(Context context) {
		this.context = context;
	}

	public String getEmergencia() {
		SharedPreferences sharedPreferences = context.getSharedPreferences(FILE_NAME, 0);
		
		return sharedPreferences.getString(TELEFONE, "190");
	}

	public void setEmergencia(String telefone) {
		SharedPreferences sharedPreferences = context.getSharedPreferences(FILE_NAME, 0);
		SharedPreferences.Editor editor = sharedPreferences.edit();
		
		editor.putString(TELEFONE, telefone);
		
		editor.commit();
	}
	
}
