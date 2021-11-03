package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

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
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;

@Service
public class ProductService extends BaseService<Product> implements Constant {

	@Autowired
	ProductImageService imageService;

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
		return super.saveOrUpdate(product);
	}

	public List<Product> getNewProduct() {
		return entityManager.createQuery("FROM Product p ORDER BY p.createdDate DESC,p.isHot DESC", Product.class)
				.setMaxResults(8).getResultList();
	}

	public List<Product> getHotProduct() {
		return entityManager.createQuery("FROM Product p ORDER BY p.isHot DESC, p.createdDate DESC", Product.class)
				.setMaxResults(8).getResultList();
	}

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

	/*
	 * @SuppressWarnings("unchecked") public List<Product>
	 * getListProductByFilter(Integer page, Integer pageSize, UserSearchProduct
	 * userSearch) { try { StringBuilder sql = new
	 * StringBuilder("SELECT * FROM perfumeshop_db.tbl_products where status=1"); if
	 * (userSearch.getKeySearch() != "" && userSearch.getKeySearch() != null) {
	 * sql.append(" and ( title like '%" + userSearch.getKeySearch() + "%'");
	 * sql.append(" or seo like '%" + userSearch.getKeySearch() + "%' )"); } if
	 * (userSearch.getMaxPrice() != null) { sql.append(" and price < ");
	 * sql.append(userSearch.getMaxPrice()); } if (userSearch.getMinPrice() != null)
	 * { sql.append(" and price > "); sql.append(userSearch.getMinPrice()); }
	 * 
	 * if (userSearch.getIdCategory() != 0) { sql.append(" and category_id=");
	 * sql.append(userSearch.getIdCategory()); }
	 * 
	 * switch (userSearch.getTypeOrder()) { case 0: break; case 1:
	 * sql.append(" order by price"); break; case 2:
	 * sql.append(" order by price desc"); break; default: break; }
	 * 
	 * if (userSearch.getTypeOrder() == 0 && userSearch.getMaxPrice() == null &&
	 * userSearch.getMinPrice() == null) {
	 * sql.append(" ORDER BY updated_date DESC,created_date DESC"); }
	 * 
	 * Query query = entityManager.createNativeQuery(sql.toString(), Product.class);
	 * query.setMaxResults(pageSize); query.setFirstResult((page - 1) * pageSize);
	 * return query.getResultList(); } catch (Exception e) { e.printStackTrace();
	 * return new ArrayList<Product>(); } }
	 */

	@SuppressWarnings("unchecked")
	public List<Product> getListProductByFilter(Integer page, Integer pageSize, UserSearchProduct userSearch) {
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
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Product>();
		}
	}

	/*
	 * public Integer getTotalPageProductByFilter(Integer pageSize,
	 * UserSearchProduct userSearch) { try { StringBuilder sql = new
	 * StringBuilder("SELECT * FROM perfumeshop_db.tbl_products where status=1"); if
	 * (userSearch.getKeySearch() != "" && userSearch.getKeySearch() != null) {
	 * sql.append(" and ( title like '%"); sql.append(userSearch.getKeySearch());
	 * sql.append("%'"); sql.append(" or seo like '%");
	 * sql.append(userSearch.getKeySearch()); sql.append("%' )"); } if
	 * (userSearch.getMaxPrice() != null) { sql.append(" and price < ");
	 * sql.append(userSearch.getMaxPrice()); } if (userSearch.getMinPrice() != null)
	 * { sql.append(" and price > "); sql.append(userSearch.getMinPrice()); }
	 * 
	 * if (userSearch.getIdCategory() != 0) { sql.append(" and category_id= ");
	 * sql.append(userSearch.getIdCategory()); }
	 * 
	 * switch (userSearch.getTypeOrder()) { case 0: break; case 1:
	 * sql.append(" order by price"); break; case 2:
	 * sql.append(" order by price desc"); break; default: break; }
	 * 
	 * if (userSearch.getTypeOrder() == 0 && userSearch.getMaxPrice() == null &&
	 * userSearch.getMinPrice() != null) {
	 * sql.append(" ORDER BY updated_date DESC,created_date DESC"); }
	 * 
	 * Query query = entityManager.createNativeQuery(sql.toString(), Product.class);
	 * Integer totalRecord = query.getResultList().size(); return totalRecord %
	 * pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1; } catch
	 * (Exception e) { e.printStackTrace(); return 0; } }
	 */

	public Long getTotalPageProductByFilter(Integer pageSize, UserSearchProduct userSearch) {
		try {
			CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Long> criteriaQuery = criteriaBuilder.createQuery(Long.class);
			Root<Product> root = criteriaQuery.from(Product.class);

			criteriaQuery.select(criteriaBuilder.count(root));

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

			Long totalRecord = entityManager.createQuery(criteriaQuery).getSingleResult();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1;
		} catch (Exception e) {
			e.printStackTrace();
			return (long) 0;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Product> getListProductByFilter(Integer page, Integer pageSize, Integer status, Integer idCategory,
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
			query.setMaxResults(pageSize);
			query.setFirstResult((page - 1) * pageSize);

			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Product>();
		}
	}

	public Integer getTotalPageProductByFilter(Integer pageSize, Integer status, Integer idCategory, String keySearch) {
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

			Integer totalRecord = entityManager.createQuery(criteriaQuery).getResultList().size();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
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
