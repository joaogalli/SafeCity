package br.com.safecity.server.controller;

import java.io.UnsupportedEncodingException;
import java.nio.charset.CharacterCodingException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.safecity.server.entity.Bairro;

@RooWebScaffold(path = "bairroes", formBackingObject = Bairro.class)
@RequestMapping("/bairroes")
@Controller
public class BairroController {

	private final Log logger = LogFactory.getLog(this.getClass());

	@RequestMapping(value = "/all/{cidade}", method = RequestMethod.GET, headers = "Accept=application/json")
	@ResponseBody
	public String findAll(@PathVariable("cidade")
	String cidade, HttpServletResponse response) throws UnsupportedEncodingException, CharacterCodingException {
		String json = Bairro.toJsonArray(Bairro.findBairroesByCidadeEquals(cidade).getResultList());
		return json;
	}

	@RequestMapping(value = "/cerca/{lat}/{lng}/{cidade}/t", method = RequestMethod.GET, headers = "Accept=application/json")
	@ResponseBody
	public String findDelitosByBairroId(HttpServletResponse response, @PathVariable("lat")
	double latitude, @PathVariable("lng")
	double longitude, @PathVariable("cidade")
	String cidade) {
		logger.info("Consultando: " + longitude + ", " + latitude);
		
		response.setHeader("Content-Type", "application/json");

		Bairro bairro = this.findBairroByLatitudeAndLongitude(latitude, longitude, cidade);
		if (bairro != null) {
			logger.info("Bairro encontrado: " + bairro.getNome());
			return bairro.toJson();
		}
		else {
			return null;
		}
	}

	/**
	 * Encontra o bairro pela latitude e longitude.
	 * @param latitude
	 * @param longitude
	 * @return
	 */
	private Bairro findBairroByLatitudeAndLongitude(double latitude, double longitude, String cidade) {
		if (cidade == null || cidade.isEmpty())
			return null;

		List<Bairro> findAllBairroes = Bairro.findBairroesByCidadeEquals(cidade).getResultList();

		for (Bairro bairro : findAllBairroes) {
			boolean cercaExists = bairro.getCerca() != null && !bairro.getCerca().isEmpty();

			if (cercaExists && isInside(bairro.getCerca(), latitude, longitude)) {
				return bairro;
			}
		}

		return null;
	}

	/**
	 * Verifica se os pontos estão dentro da cerca.
	 * @param cerca
	 * @param latitude
	 * @param longitude
	 * @return
	 */
	private boolean isInside(String cerca, double latitude, double longitude) {
		try {
			double[][] points = toDouble(cerca.split("[|]"));
			double[] xpoints = new double[points.length];
			double[] ypoints = new double[points.length];

			for (int i = 0; i < points.length; i++) {
				double[] ds = points[i];
				xpoints[i] = ds[0];
				ypoints[i] = ds[1];
			}

			Polygon2D p = new Polygon2D(xpoints, ypoints, points.length);

			return p.contains(latitude, longitude);
		}
		catch (Exception e) {
			logger.error("Erro calculando a cerca.", e);
			return false;
		}
	}

	/**
	 * Transforma os pontos em array de double.
	 */
	private double[][] toDouble(String[] cercas) {
		double[][] points = new double[cercas.length][2];

		for (int i = 0; i < points.length; i++) {
			String[] ll = cercas[i].split("[,]");
			points[i][0] = Double.parseDouble(ll[0]);
			points[i][1] = Double.parseDouble(ll[1]);
		}

		return points;
	}
}
