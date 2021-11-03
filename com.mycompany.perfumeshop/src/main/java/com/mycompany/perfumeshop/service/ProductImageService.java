package com.mycompany.perfumeshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mycompany.perfumeshop.entities.ProductImage;

@Service
public class ProductImageService extends BaseService<ProductImage>{

	@Override
	protected Class<ProductImage> clazz() {
		return ProductImage.class;
	}

	public List<ProductImage> getListByIdProduct(Integer idProduct) {
		return executeNativeSql("SELECT * FROM electronicdeviceshop.tbl_products_images where product_id=" + idProduct);
	}
}
