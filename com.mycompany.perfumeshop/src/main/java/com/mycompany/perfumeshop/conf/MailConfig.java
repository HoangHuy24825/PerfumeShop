package com.mycompany.perfumeshop.conf;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.mycompany.perfumeshop.dto.Constant;

@Configuration
public class MailConfig implements Constant{
	@Bean
	public JavaMailSender getJavaMailSender(){
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);

		mailSender.setUsername(MY_EMAIL);
		mailSender.setPassword(MY_PASSWORD);

		Properties props = mailSender.getJavaMailProperties();
		props.put("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.allow8bitmime", "true");
		props.setProperty("mail.smtps.allow8bitmime", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.debug", "true");
		
		return mailSender;
	}
	
}
