package br.com.i4people.safecity.persistence.shared;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;

/**
 * @author joaoeduardogalli
 *
 */
public class ContatoDao {

	private static final String FILE_NAME = "shared_contatos";
	
	public static final String NOME = "nome";
	
	public static final String TELEFONE = "telefone";

	private final Context context;
	
	public static enum Contato {
		CONTATO1("contato1"),
		CONTATO2("contato2"),
		CONTATO3("contato3");
		
		public String prefix;
		
		private Contato(String prefix) {
			this.prefix = prefix;
		}
	}
	
	public ContatoDao(Context context) {
		this.context = context;
	}

	public Bundle getContato(Contato contato) {
		Bundle bundle = new Bundle(2);
		
		SharedPreferences sharedPreferences = context.getSharedPreferences(FILE_NAME, 0); 
		bundle.putString(NOME, sharedPreferences.getString(contato.prefix+NOME, "Sem nome"));
		bundle.putString(TELEFONE, sharedPreferences.getString(contato.prefix+TELEFONE, "Sem telefone"));
		
		return bundle;
	}
	
	public void setContato(Contato contato, String nome, String telefone) {
		SharedPreferences sharedPreferences = context.getSharedPreferences(FILE_NAME, 0);
		SharedPreferences.Editor editor = sharedPreferences.edit();
		
		editor.putString(contato.prefix+NOME, nome);
		editor.putString(contato.prefix+TELEFONE, telefone);
		
		editor.commit();
	}

	public CharSequence getPreviewForContato(Contato contato1) {
		Bundle contato = getContato(contato1);
		return contato.getString(NOME) + ": " + contato.getString(TELEFONE);
	}
	
}
