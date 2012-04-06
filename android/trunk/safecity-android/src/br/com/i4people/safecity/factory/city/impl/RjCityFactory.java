package br.com.i4people.safecity.factory.city.impl;

import br.com.i4people.safecity.R;
import br.com.i4people.safecity.factory.city.CityFactory;

/**
 * @author joaoeduardogalli
 * 
 */
public class RjCityFactory implements CityFactory {

	@Override
	public int getLoadingCityNameResource() {
		return R.drawable.m_rj_localizando;
	}

	@Override
	public int getLoadingLocalizandoResource() {
		return R.drawable.m_branco_localizando;
	}

	@Override
	public int getLoadingBackgroundResource() {
		return R.drawable.m_background_rj_localizando;
	}

	@Override
	public int getScreenBackgroundResource() {
		return R.drawable.background_tela_rj;
	}

	@Override
	public int getMensagemAvisoLegalId() {
		return R.string.aviso_legal_rj;
	}

}
