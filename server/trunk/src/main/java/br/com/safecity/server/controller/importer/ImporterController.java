package br.com.safecity.server.controller.importer;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import br.com.safecity.server.entity.Bairro;

/**
 * @author joaoeduardogalli
 * 
 */
@RequestMapping("/import")
@Controller
public class ImporterController {

	private final Log logger = LogFactory.getLog(this.getClass());

	@Transactional
	@RequestMapping(value = "/all", method = RequestMethod.POST)
	public void imports(@RequestParam("p")
	String path, HttpServletResponse response) throws IOException {
		BufferedReader rd = new BufferedReader(new FileReader(path));
		String line = null;
		int i = 0;
		while ((line = rd.readLine()) != null) {
			if (i++ == 0) {
				continue; // Cabeçalho da tabela.
			}
			// ISO-8859-1
			processLine(line);
		}

		logger.info("Quantidade de bairros importados: " + i);

		rd.close();
	}

	@Transactional
	@RequestMapping(value = "/multiple", method = RequestMethod.POST)
	public void importMultiple(@RequestParam("apagarRegistros") String apagarRegistros, @RequestParam("cidade")
	String cidade, @RequestParam("p")
	String path, HttpServletResponse response) throws IOException {
		
		logger.info("Apagar registros: " + apagarRegistros);
		if (Boolean.TRUE.equals(Boolean.parseBoolean(apagarRegistros))) {
			List<Bairro> resultList = Bairro.findBairroesByCidadeEquals(cidade).getResultList();
			for (Bairro bairro : resultList) {
				bairro.remove();
				bairro.flush();
			}
		}
		
		String[] lines = path.split("[\n]");

		for (String line : lines) {
			String[] fields = processLine(line);
			createNewBairro(cidade, fields);
		}
		
		PrintWriter writer = response.getWriter();
		writer.write("<h1>A importacao foi finalizada com sucesso.</h1>");
		writer.flush();
	}

	private String[] processLine(String line) {
		String[] fields = line.split("\t");

		//logger.info("Campos: " + fields.length + ": " + line);

		return fields;
	}

	private void createNewBairro(String cidade, String[] fields) {
		Bairro b = new Bairro();

		b.setCidade(cidade);
		b.setNome(getFromArray(fields, 0));
		b.setZona(getFromArray(fields, 1));
		b.setAlertaEspecial(getFromArray(fields, 2));
		b.setDelito1(getFromArray(fields, 3));
		b.setDelito2(getFromArray(fields, 4));
		b.setDica1(getFromArray(fields, 5));
		b.setDica2(getFromArray(fields, 6));
		b.setDica3(getFromArray(fields, 7));
		b.setDica4(getFromArray(fields, 8));
		b.setDelegaciaEndereco1(getFromArray(fields, 9));
		b.setDelegaciaTelefone1(getFromArray(fields, 10));
		b.setDelegaciaEndereco2(getFromArray(fields, 11));
		b.setDelegaciaTelefone2(getFromArray(fields, 12));
		b.setHospitalEndereco1(getFromArray(fields, 13));
		b.setHospitalTelefone1(getFromArray(fields, 14));
		b.setHospitalEndereco2(getFromArray(fields, 15));
		b.setHospitalTelefone2(getFromArray(fields, 16));
		b.setCerca(getFromArray(fields, 17));

		b.merge();
		b.flush();
	}

	/**
	 * Safe get an element from array.
	 */
	private String getFromArray(String[] fields, int i) {
		try {
			return fields[i];
		}
		catch (Exception e) {
			return null;
		}
	}

}
