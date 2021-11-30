package com.mycompany.perfumeshop.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.repository.ReviewRepository;
import com.mycompany.perfumeshop.service.ReviewService;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewRepository reviewRepository;

	@Override
	public List<Review> findByProduct(Product product) throws Exception {
		if (product == null) {
			return new ArrayList<Review>();
		}
		return reviewRepository.findByProduct(product);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		reviewRepository.deleteById(id);
		return true;
	}
}
