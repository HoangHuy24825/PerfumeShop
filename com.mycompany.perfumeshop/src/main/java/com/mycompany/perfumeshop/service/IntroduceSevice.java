package com.mycompany.perfumeshop.service;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Introduce;

@Service
public class IntroduceSevice extends BaseService<Introduce> {

	@Override
	protected Class<Introduce> clazz() {
		return Introduce.class;
	}

}
