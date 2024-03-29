// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package br.com.safecity.server.controller;

import br.com.safecity.server.entity.Bairro;
import java.lang.String;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(new BairroConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
    static class br.com.safecity.server.controller.ApplicationConversionServiceFactoryBean.BairroConverter implements Converter<Bairro, String> {
        public String convert(Bairro bairro) {
            return new StringBuilder().append(bairro.getNome()).append(" ").append(bairro.getCerca()).append(" ").append(bairro.getZona()).append(" ").append(bairro.getDelito1()).toString();
        }
        
    }
    
}
