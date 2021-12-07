package com.mycompany.perfumeshop.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.ProductImageRepository;
import com.mycompany.perfumeshop.service.ProductImageService;

@Service
@Transactional
public class ProductImageServiceImpl implements ProductImageService {

	@Autowired
	private ProductImageRepository imageRepository;

	@Autowired
	private GlobalConfig globalConfig;

	public List<ProductImage> findByProduct(Product product) {
		return imageRepository.findByProduct(product);
	}

	@Override
	public Boolean deleteById(Integer id) throws Exception {
		ProductImage productImage = imageRepository.findById(id)
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found image has id: " + id));
		new File(globalConfig.getUploadRootPath() + productImage.getPath() + productImage.getTitle()).delete();
		imageRepository.deleteById(id);
		return true;
	}
}
