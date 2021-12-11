package com.mycompany.perfumeshop.service;

import org.springframework.data.domain.Page;

import com.mycompany.perfumeshop.entities.Contact;
import com.mycompany.perfumeshop.entities.User;

public interface ContactService {

	Contact saveOrUpdate(Contact contact, User userEdit) throws Exception;

	Page<Contact> findAll(String keySearch, String currentPage, Integer sizeOfPage);

	Contact findById(String id) throws Exception;

	Boolean delete(String id) throws Exception;
}
