package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.slugify.Slugify;
import com.mycompany.perfumeshop.dto.Constant;
import com.mycompany.perfumeshop.dto.UserSearchProduct;
import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Service
public class ProductService extends BaseService<Product> implements Constant {

	@Autowired
	ProductImageService imageService;

	@Autowired
	ProductAttributeService attributeService;

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	protected Class<Product> clazz() {
		return Product.class;
	}

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	private boolean isEmptyUploadFile(MultipartFile[] images) {
		if (images == null || images.length <= 0 || (images.length > 0 && images[0].getOriginalFilename().isEmpty())) {
			return true;
		}
		return false;
	}

	@Transactional
	public Product save(Product product, MultipartFile avatar, MultipartFile[] images) throws Exception {
		if (!isEmptyUploadFile(avatar)) {
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "product/avatar/" + avatar.getOriginalFilename()));
			product.setAvatar("product/avatar/" + avatar.getOriginalFilename());
		}

		if (!isEmptyUploadFile(images)) {
			for (MultipartFile image : images) {
				image.transferTo(new File(UPLOAD_ROOT_PATH + "product/images/" + image.getOriginalFilename()));

				ProductImage img = new ProductImage();
				img.setPath("product/images/");
				img.setTitle(image.getOriginalFilename());
				product.addImage(img);
			}
		}
		product.setSeo(new Slugify().slugify(product.getTitle()));
		product.setCreatedDate(Calendar.getInstance().getTime());
		return super.saveOrUpdate(product);
	}

	@Transactional
	public Product edit(Product product, MultipartFile avatar, MultipartFile[] images) throws Exception {
		Product oldProduct = super.getById(product.getId());
		if (!isEmptyUploadFile(avatar)) {
			new File(UPLOAD_ROOT_PATH + oldProduct.getAvatar()).delete();
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "product/avatar/" + avatar.getOriginalFilename()));
			product.setAvatar("product/avatar/" + avatar.getOriginalFilename());
		} else {
			product.setAvatar(oldProduct.getAvatar());
		}

		if (!isEmptyUploadFile(images)) {
			List<ProductImage> oldImages = imageService.getListByIdProduct(product.getId());

			for (ProductImage productImage : oldImages) {
				imageService.delete(productImage);
				oldProduct.removeImage(productImage);
				new File(UPLOAD_ROOT_PATH + productImage.getPath() + productImage.getTitle()).delete();
			}

			for (MultipartFile image : images) {
				image.transferTo(new File(UPLOAD_ROOT_PATH + "product/images/" + image.getOriginalFilename()));

				ProductImage img = new ProductImage();
				img.setPath("product/images/");
				img.setTitle(image.getOriginalFilename());
				product.addImage(img);
			}
		}
		product.setSeo(new Slugify().slugify(product.getTitle()));
		product.setUpdatedDate(Calendar.getInstance().getTime());
		product.setCreatedDate(oldProduct.getCreatedDate());
		product.setCreatedBy(oldProduct.getCreatedBy());
		List<AttributeProduct> attributeProducts = attributeService.getListByIdProduct(oldProduct.getId());
		List<AttributeProduct> newAttributeProducts = product.getAttributeProducts();
		for (AttributeProduct attributeProduct : attributeProducts) {
			if (!checkExistsAttr(newAttributeProducts, attributeProduct)) {
				attributeService.delete(attributeProduct);
			}
		}
		return super.saveOrUpdate(product);
	}

	private boolean checkExistsAttr(List<AttributeProduct> attributeProducts, AttributeProduct attributeProduct) {
		for (AttributeProduct attr : attributeProducts) {
			if (attributeProduct.getId() == attr.getId()) {
				return true;
			}
		}
		return false;
	}

	public List<Product> getNewProduct() {
		return entityManager.createQuery("FROM Product p ORDER BY p.createdDate DESC,p.isHot DESC", Product.class)
				.setMaxResults(8).getResultList();
	}

	public List<Product> getHotProduct() {
		return entityManager.createQuery("FROM Product p ORDER BY p.isHot DESC, p.createdDate DESC", Product.class)
				.setMaxResults(8).getResultList();
	}

	/**
	 * Get list product when customer chose category
	 * 
	 * @param page
	 * @param pageSize
	 * @param idCategory
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Product> getListProductByCategory(Integer page, Integer pageSize, Integer idCategory) {
		try {
			StringBuilder sql = new StringBuilder(
					"FROM Product p where p.status=1 and p.category.id=:idCategory ORDER BY p.updatedDate DESC, p.createdDate DESC");
			Query query = entityManager.createQuery(sql.toString(), Product.class);
			query.setParameter("idCategory", idCategory);
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Product>();
		}

	}

	/**
	 * This method to find all product in client page
	 * 
	 * @param page
	 * @param pageSize
	 * @param userSearch
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public BaseVo<Product> getListProductByFilter(Integer page, Integer pageSize, UserSearchProduct userSearch) {
		try {
			CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Product> criteriaQuery = criteriaBuilder.createQuery(Product.class);
			Root<Product> root = criteriaQuery.from(Product.class);

			criteriaQuery.select(root);

			List<Predicate> predicates = new ArrayList<>();

			predicates.add(criteriaBuilder.equal(root.get("status"), true));

			if (userSearch.getKeySearch() != "" && userSearch.getKeySearch() != null) {
				predicates.add(criteriaBuilder.or(
						criteriaBuilder.like(root.get("title"), "%" + userSearch.getKeySearch() + "%"),
						criteriaBuilder.like(root.get("seo"), "%" + userSearch.getKeySearch() + "%")));
			}

			// Thuc hien sau

			/*
			 * if (userSearch.getMaxPrice() != null) { sql.append(" and price < ");
			 * sql.append(userSearch.getMaxPrice()); } if (userSearch.getMinPrice() != null)
			 * { sql.append(" and price > "); sql.append(userSearch.getMinPrice()); }
			 */

			if (userSearch.getIdCategory() != 0) {
				predicates.add(criteriaBuilder.equal(root.get("category").get("id"), userSearch.getIdCategory()));
			}

			// Thuc hien sau
			/*
			 * switch (userSearch.getTypeOrder()) { case 0: break; case 1:
			 * sql.append(" order by price");
			 * criteriaQuery.orderBy(criteriaBuilder.desc(root.get)) break; case 2:
			 * sql.append(" order by price desc"); break; default: break; }
			 */

			if (userSearch.getTypeOrder() == 0 && userSearch.getMaxPrice() == null
					&& userSearch.getMinPrice() != null) {
				criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")),
						criteriaBuilder.desc(root.get("updatedDate")));
			}

			Query query = entityManager.createQuery(criteriaQuery);

			int totalRecs = query.getResultList().size();
			int totalPage = totalRecs / pageSize;
			totalPage = totalRecs % pageSize == 0 ? totalPage : totalPage + 1;

			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);

			BaseVo<Product> result = new BaseVo<Product>();
			result.setListEntity(query.getResultList());
			result.setCurrentPage(page);
			result.setTotalPage(totalPage);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * This method to find all product in admin page
	 * 
	 * @param page
	 * @param pageSize
	 * @param status
	 * @param idCategory
	 * @param keySearch
	 * @return BaseVo<Product>
	 */
	@SuppressWarnings("unchecked")
	public BaseVo<Product> getListProductByFilter(Integer page, Integer pageSize, Integer status, Integer idCategory,
			String keySearch) {
		try {
			CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Product> criteriaQuery = criteriaBuilder.createQuery(Product.class);
			Root<Product> root = criteriaQuery.from(Product.class);
			criteriaQuery.select(root);
			List<Predicate> predicates = new ArrayList<>();
			if (status != null) {
				predicates.add(criteriaBuilder.equal(root.get("status"), status));
			}
			if (keySearch != null && keySearch != "") {
				predicates.add(criteriaBuilder.or(criteriaBuilder.like(root.get("title"), "%" + keySearch + "%"),
						criteriaBuilder.like(root.get("seo"), "%" + keySearch + "%")));
			}
			if (idCategory != 0) {
				predicates.add(criteriaBuilder.equal(root.get("category").get("id"), idCategory));
			}
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("updatedDate")),
					criteriaBuilder.desc(root.get("createdDate")));
			Query query = entityManager.createQuery(criteriaQuery);

			int totalRecs = query.getResultList().size();
			int numPage = totalRecs / pageSize;
			numPage = totalRecs % pageSize == 0 ? numPage : numPage + 1;

			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);

			BaseVo<Product> result = new BaseVo<Product>();
			result.setListEntity(query.getResultList());
			result.setCurrentPage(page);
			result.setTotalPage(numPage);

			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Transactional
	public Boolean deleteProductById(Integer idProduct) {
		try {

			Query query = entityManager.createQuery("FROM OrderDetail od WHERE od.product.id=:idProduct",
					Product.class);
			query.setParameter("idProduct", idProduct);
			List<OrderDetail> saleOrderProducts = query.getResultList();

			if (saleOrderProducts.size() == 0) {
				Product product = super.getById(idProduct);
				List<ProductImage> productImages = imageService.getListByIdProduct(idProduct);
				for (ProductImage productImage : productImages) {
					new File(UPLOAD_ROOT_PATH + productImage.getPath() + productImage.getTitle()).delete();
				}
				new File(UPLOAD_ROOT_PATH + product.getAvatar()).delete();

				entityManager.createQuery("DELETE FROM ProductImage pi WHERE pi.product.id=:productID")
						.setParameter("productID", idProduct).executeUpdate();
				entityManager.createQuery("DELETE FROM Product p WHERE p.id=:productID")
						.setParameter("productID", idProduct).executeUpdate();
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}
}
