package com.mycompany.perfumeshop.service;

import java.util.List;

import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;

public interface ProductImageService {

	List<ProductImage> findByProduct(Product product);

	boolean delete(ProductImage image);

}
