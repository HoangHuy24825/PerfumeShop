package com.mycompany.perfumeshop.service.impl;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.repository.NotifyRepository;
import com.mycompany.perfumeshop.service.NotifyService;
import com.mycompany.perfumeshop.utils.Validate;

@Service
@Transactional
public class NotifyServiceImpl implements NotifyService {

	@Autowired
	private NotifyRepository notifyRepository;

	@Override
	public Boolean deleteById(String id) throws Exception {
		if (!Validate.isNumber(id)) {
			return false;
		}
		notifyRepository.deleteById(Integer.parseInt(id));
		return true;
	}

}
