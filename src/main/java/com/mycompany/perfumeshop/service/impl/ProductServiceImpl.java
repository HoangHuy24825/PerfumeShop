package com.mycompany.perfumeshop.service.impl;

import java.io.File;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.slugify.Slugify;
import com.mycompany.perfumeshop.conf.GlobalConfig;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.exceptions.EntityNotFoundCustomException;
import com.mycompany.perfumeshop.repository.AttributeProductRepository;
import com.mycompany.perfumeshop.repository.ImageRepository;
import com.mycompany.perfumeshop.repository.OrderDetailRepository;
import com.mycompany.perfumeshop.repository.ProductRepository;
import com.mycompany.perfumeshop.service.ProductService;
import com.mycompany.perfumeshop.specification.ProductSpecification;
import com.mycompany.perfumeshop.utils.Validate;
import com.mycompany.perfumeshop.valueObjects.UserRequestToProduct;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

	@Autowired
	private AttributeProductRepository attributeProductRepository;

	@Autowired
	private OrderDetailRepository orderDetailRepository;

	@Autowired
	private ImageRepository imageRepository;

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private ProductSpecification productSpecification;

	@Autowired
	private GlobalConfig globalConfig;

	@Override
	public Product saveOrUpdate(Product product, MultipartFile avatar, MultipartFile[] images, User userLogin)
			throws Exception {
		Integer idUserLogin = userLogin != null ? userLogin.getId() : null;
		product.setSeo(new Slugify().slugify(product.getTitle()));
		product.setUpdatedDate(Calendar.getInstance().getTime());
		product.setUpdatedBy(idUserLogin);
		if (product.getId() != null) {
			Product oldProduct = productRepository.findById(product.getId())
					.orElseThrow(() -> new EntityNotFoundCustomException("Not found product by id=" + product.getId()));
			if (!Validate.isEmptyUploadFile(avatar)) {
				new File(globalConfig.getUploadRootPath() + oldProduct.getAvatar()).delete();
				avatar.transferTo(
						new File(globalConfig.getUploadRootPath() + "product/avatar/" + avatar.getOriginalFilename()));
				product.setAvatar("product/avatar/" + avatar.getOriginalFilename());
			} else {
				product.setAvatar(oldProduct.getAvatar());
			}

			if (!Validate.isEmptyUploadFile(images)) {
				List<ProductImage> oldImages = imageRepository.findByProduct(product);

				for (ProductImage productImage : oldImages) {
					imageRepository.delete(productImage);
					oldProduct.removeImage(productImage);
					new File(globalConfig.getUploadRootPath() + productImage.getPath() + productImage.getTitle())
							.delete();
				}

				for (MultipartFile image : images) {
					image.transferTo(new File(
							globalConfig.getUploadRootPath() + "product/images/" + image.getOriginalFilename()));

					ProductImage img = new ProductImage();
					img.setPath("product/images/");
					img.setTitle(image.getOriginalFilename());
					product.addImage(img);
				}
			}
			List<AttributeProduct> attributeProducts = attributeProductRepository.findByProduct(oldProduct);
			List<AttributeProduct> newAttributeProducts = product.getAttributeProducts();
			for (AttributeProduct attributeProduct : attributeProducts) {
				if (!checkExistsAttr(newAttributeProducts, attributeProduct)) {
					attributeProductRepository.delete(attributeProduct);
				}
			}
		} else {
			if (!Validate.isEmptyUploadFile(avatar)) {
				avatar.transferTo(
						new File(globalConfig.getUploadRootPath() + "product/avatar/" + avatar.getOriginalFilename()));
				product.setAvatar("product/avatar/" + avatar.getOriginalFilename());
			}

			if (!Validate.isEmptyUploadFile(images)) {
				for (MultipartFile image : images) {
					image.transferTo(new File(
							globalConfig.getUploadRootPath() + "product/images/" + image.getOriginalFilename()));

					ProductImage img = new ProductImage();
					img.setPath("product/images/");
					img.setTitle(image.getOriginalFilename());
					product.addImage(img);
				}
			}
			product.setCreatedDate(Calendar.getInstance().getTime());
			product.setStatus(true);
		}
		return productRepository.save(product);
	}

	private boolean checkExistsAttr(List<AttributeProduct> attributeProducts, AttributeProduct attributeProduct) {
		for (AttributeProduct attr : attributeProducts) {
			if (attributeProduct.getId() == attr.getId()) {
				return true;
			}
		}
		return false;
	}

	@Override
	public Boolean deleteById(String idProduct) throws Exception {
		if (!Validate.isNumber(idProduct)) {
			return false;
		}
		Product product = productRepository.findById(Integer.parseInt(idProduct))
				.orElseThrow(() -> new EntityNotFoundCustomException("Not found product by id=" + idProduct));
		List<AttributeProduct> attributeProducts = attributeProductRepository.findByProduct(product);
		for (AttributeProduct attributeProduct : attributeProducts) {
			if (orderDetailRepository.findByAttributeProduct(attributeProduct).size() > 0) {
				return false;
			}
		}
		List<ProductImage> images = imageRepository.findByProduct(product);
		for (ProductImage productImage : images) {
			new File(globalConfig.getUploadRootPath() + productImage.getPath() + productImage.getTitle()).delete();
		}
		new File(globalConfig.getUploadRootPath() + product.getAvatar()).delete();
		productRepository.delete(product);
		return true;
	}

	@Override
	public List<Product> findTop8NewProduct() throws Exception {
		return productRepository.findTop8ByOrderByCreatedDateDesc();
	}

	@Override
	public List<Product> findTop8ProductHot() throws Exception {
		return productRepository.findTop8ByIsHotOrderByCreatedDateDesc(true);
	}

	@Override
	public Page<Product> findByUserRequestToProduct(UserRequestToProduct request) throws Exception {
		Pageable pageable = PageRequest.of(request.getCurrentPage() - 1, request.getSizeOfPage(),
				Sort.by("createdDate").descending().and(Sort.by("updatedDate").descending()));
		return productRepository.findAll(productSpecification.findByUserRequestToProduct(request), pageable);
	}

	@Override
	public Product findBySeo(String seo) throws Exception {
		if (seo == null || seo.trim() == "") {
			return null;
		}
		return productRepository.findBySeo(seo);
	}

	@Override
	public List<Product> findByStatus(Boolean status) throws Exception {
		if (status == null) {
			return productRepository.findAll();
		}
		return productRepository.findByStatus(status);
	}

	@Override
	public Product findById(String id) throws Exception {
		if (!Validate.isNumber(id)) {
			return null;
		}
		return productRepository.findById(
				Integer.parseInt(id)).orElseThrow(() -> new EntityNotFoundCustomException("Not found product"));
	}

	@Override
	public Product saveOrUpdate(Product product, User userLogin) throws Exception {
		Integer idUserLogin = userLogin != null ? userLogin.getId() : null;
		if (product.getId() != null) {
			Product oldProduct = productRepository.findById(product.getId())
					.orElseThrow(() -> new EntityNotFoundCustomException("Not found introduce"));
			product.setCreatedBy(oldProduct.getCreatedBy());
			product.setCreatedDate(oldProduct.getCreatedDate());
		} else {
			product.setCreatedBy(idUserLogin);
			product.setCreatedDate(Calendar.getInstance().getTime());
		}
		product.setUpdatedBy(idUserLogin);
		product.setUpdatedDate(Calendar.getInstance().getTime());
		return productRepository.save(product);
	}

}
