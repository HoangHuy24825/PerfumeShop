package com.mycompany.perfumeshop.service;

import java.util.List;

import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.User;

public interface AttributeProductService {

	public List<AttributeProduct> findAllByProduct(Product product) throws Exception;

	public Boolean deleteById(Integer id) throws Exception;

	AttributeProduct findById(Integer id) throws Exception;

	AttributeProduct saveOrUpdate(AttributeProduct attributeProduct, User userLogin) throws Exception;

}
