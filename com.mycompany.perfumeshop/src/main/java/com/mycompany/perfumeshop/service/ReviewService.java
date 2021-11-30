package com.mycompany.perfumeshop.service;

import java.util.List;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;

public interface ReviewService {

	List<Review> findByProduct(Product product) throws Exception;

	public Boolean deleteById(Integer id) throws Exception;

}
