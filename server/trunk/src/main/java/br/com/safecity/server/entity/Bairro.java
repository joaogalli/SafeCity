package br.com.safecity.server.entity;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import javax.persistence.Column;
import org.springframework.roo.addon.json.RooJson;

@RooJavaBean
@RooToString
@RooJson
@RooEntity(finders = { "findBairroesByCidadeEquals" })
public class Bairro {

    @NotNull
    @Column(unique = true)
    private String nome;

    @Column(length = 99999)
    private String cerca;

    private String zona;

    private String delito1;

    private String delito2;

    private String alertaEspecial;

    private String dica1;

    private String dica2;

    private String dica3;

    private String dica4;

    private String delegaciaEndereco1;

    private String delegaciaTelefone1;

    private String delegaciaEndereco2;

    private String delegaciaTelefone2;

    private String hospitalEndereco1;

    private String hospitalTelefone1;

    private String hospitalEndereco2;

    private String hospitalTelefone2;

    private String hospitalEndereco3;

    private String hospitalTelefone3;

    @NotNull
    private String cidade;
}
