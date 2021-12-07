package com.mycompany.perfumeshop.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.valueObjects.UserRequestReview;

public interface ReviewService {

	List<Review> findByProduct(Product product) throws Exception;

	public Boolean deleteById(String id) throws Exception;

	Review saveOrUpdate(Review review, User userLogin) throws Exception;

	Page<Review> findAll(UserRequestReview userRequestReview) throws Exception;
	
	Review findById(String id) throws Exception;
}
