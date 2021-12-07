package com.mycompany.perfumeshop.valueObjects;

import lombok.NoArgsConstructor;
import lombok.Setter;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Component
public class CustomerOrder {
	private String name;
	private String address;
	private String phone;
	private String email;
}
