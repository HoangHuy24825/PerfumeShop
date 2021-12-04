package com.mycompany.perfumeshop.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.OrderDetailRepository;
import com.mycompany.perfumeshop.repository.ReviewRepository;
import com.mycompany.perfumeshop.repository.UserRepository;
import com.mycompany.perfumeshop.service.ReviewService;
import com.mycompany.perfumeshop.specification.OrderDetailSpecification;
import com.mycompany.perfumeshop.valueObjects.CustomerOrder;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewRepository reviewRepository;

	@Autowired
	private OrderDetailRepository orderDetailRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private OrderDetailSpecification orderDetailSpecification;

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

	@Override
	public Review saveOrUpdate(Review review, User userLogin) throws Exception {
		CustomerOrder customerOrder = null;
		if (userLogin != null) {
			customerOrder = new CustomerOrder(userLogin.getFullname(), userLogin.getAddress(), userLogin.getPhone(),
					userLogin.getEmail());
			if (review.getId() == null) {
				review.setCreatedBy(userLogin.getId());
				review.setCreatedDate(Calendar.getInstance().getTime());
				review.setCustomerAddress(userLogin.getAddress());
				review.setCustomerName(userLogin.getFullname());
				review.setCustomerEmail(userLogin.getEmail());
				review.setCustomerPhone(userLogin.getPhone());
				review.setStatus(false);
			} else {
				Review oldReview = reviewRepository.findById(review.getId())
						.orElseThrow(() -> new EntityNotFoundCustomException("Not found review"));
				review.setCreatedBy(oldReview.getCreatedBy());
				review.setCreatedDate(oldReview.getCreatedDate());
			}
			review.setUpdatedBy(userLogin.getId());
			review.setUser(userLogin);
		} else {
			customerOrder = new CustomerOrder(review.getCustomerName(), review.getCustomerAddress(),
					review.getCustomerPhone(), review.getCustomerEmail());
		}
		List<OrderDetail> orderDetails = orderDetailRepository
				.findAll(orderDetailSpecification.findByCustomerOrder(customerOrder, review.getProduct()));
		if (orderDetails.size() == 0) {
			return null;
		}
		if (orderDetails.get(0).getOrder().getUserID() != null && orderDetails.get(0).getOrder().getUserID() != 0
				&& userLogin == null) {
			review.setUser(userRepository.findById(orderDetails.get(0).getOrder().getUserID())
					.orElseThrow(() -> new EntityNotFoundCustomException("Not found User")));
		}
		review.setUpdatedDate(Calendar.getInstance().getTime());
		return reviewRepository.save(review);
	}
}
