package com.mycompany.perfumeshop.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.AttributeProductRepository;
import com.mycompany.perfumeshop.service.AttributeProductService;
import com.mycompany.perfumeshop.utils.Log4jUtils;
import com.mycompany.perfumeshop.valueObjects.CategoryQuantityProduct;

@Service
@Transactional
public class AttributeProductServiceImpl implements AttributeProductService {

	@Autowired
	private AttributeProductRepository attrRepository;

	@Override
	public List<AttributeProduct> findAllByProduct(Product product) throws Exception {
		if (product == null) {
			return new ArrayList<AttributeProduct>();
		}
		return attrRepository.findByProduct(product);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		attrRepository.deleteById(id);
		return true;
	}

	@Override
	public AttributeProduct findById(Integer id) throws Exception {
		return attrRepository.findById(id)
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found attribute product has id: " + id));
	}

	@Override
	public AttributeProduct saveOrUpdate(AttributeProduct attributeProduct, User userLogin) throws Exception {
		Integer idUserLogin = userLogin != null ? userLogin.getId() : null;
		if (attributeProduct.getId() != null) {
			AttributeProduct oldAttr = attrRepository.findById(attributeProduct.getId())
					.orElseThrow(() -> new EntityNotFoundCustomException(
							"Not found attribute product has id: " + attributeProduct.getId()));
			attributeProduct.setCreatedBy(oldAttr.getCreatedBy());
			attributeProduct.setCreatedDate(oldAttr.getCreatedDate());
		}
		attributeProduct.setUpdatedBy(idUserLogin);
		attributeProduct.setUpdatedDate(Calendar.getInstance().getTime());
		return attrRepository.save(attributeProduct);
	}

}
