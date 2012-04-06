package br.com.i4people.safecity.factory.city.impl;

import br.com.i4people.safecity.R;
import br.com.i4people.safecity.factory.city.CityFactory;

/**
 * @author joaoeduardogalli
 * 
 */
public class SpCityFactory implements CityFactory {

	@Override
	public int getLoadingCityNameResource() {
		return R.drawable.m_sp_localizando;
	}

	@Override
	public int getLoadingLocalizandoResource() {
		return R.drawable.m_preto_localizando;
	}

	@Override
	public int getLoadingBackgroundResource() {
		return R.drawable.m_background_sp_localizando;
	}

	@Override
	public int getScreenBackgroundResource() {
		return R.drawable.background_tela_sp;
	}

	@Override
	public int getMensagemAvisoLegalId() {
		return R.string.aviso_legal_sp;
	}

}
