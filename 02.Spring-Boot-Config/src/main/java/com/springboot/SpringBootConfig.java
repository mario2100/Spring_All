package com.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

import com.springboot.bean.ConfigBean;
import com.springboot.bean.TestConfigBean;

@SpringBootApplication
@EnableConfigurationProperties({ConfigBean.class,TestConfigBean.class})
//@ImportResource({"classpath:some-application.xml"})
public class SpringBootConfig {
	
	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(SpringBootConfig.class);
		app.setAddCommandLineProperties(false);
		app.run(args);
	}
}
