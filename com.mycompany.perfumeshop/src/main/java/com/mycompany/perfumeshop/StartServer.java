package com.mycompany.perfumeshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StartServer {
	public static void main(String[] args) {
		System.out.println("start server............");
		SpringApplication.run(StartServer.class, args);
	}
}
