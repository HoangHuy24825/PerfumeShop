package com.mycompany.perfumeshop.service;

import java.util.List;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.entities.User;

public interface ReviewService {

	List<Review> findByProduct(Product product) throws Exception;

	public Boolean deleteById(Integer id) throws Exception;

	Review saveOrUpdate(Review review, User userLogin) throws Exception;
}
