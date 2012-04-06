package br.com.i4people.safecity.activity;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.factory.city.AbstractCityFactory;
import br.com.i4people.safecity.factory.city.CityFactory;

/**
 * @author joaoeduardogalli
 * 
 */
public class AvisoLegalActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.aviso_legal);

		TextView mensagemView = (TextView) findViewById(R.id.aviso_description);

		CityFactory cityFactory = AbstractCityFactory.getCityFactory(this);

		String mensagem = getString(cityFactory.getMensagemAvisoLegalId());

		mensagemView.setText(mensagem);
	}

}
