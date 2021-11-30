package com.mycompany.perfumeshop.service.impl;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.repository.NotifyRepository;
import com.mycompany.perfumeshop.service.NotifyService;

@Service
@Transactional
public class NotifyServiceImpl  implements NotifyService {

	@Autowired
	private NotifyRepository notifyRepository;

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		notifyRepository.deleteById(id);
		return true;
	}

}
