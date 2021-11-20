package com.mycompany.perfumeshop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.repository.ProductImageRepository;
import com.mycompany.perfumeshop.service.ProductImageService;

@Service
@Transactional
public class ProductImageServiceImpl implements ProductImageService {

	@Autowired
	private ProductImageRepository imageRepository;

	public List<ProductImage> findByProduct(Product product) {
		return imageRepository.findByProduct(product);
	}

	@Override
	public boolean delete(ProductImage image) {
		imageRepository.delete(image);
		return true;
	}
}
