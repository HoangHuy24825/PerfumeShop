package com.mycompany.perfumeshop.dto;

import java.text.SimpleDateFormat;

import org.json.simple.JSONObject;

import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.entities.Introduce;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.User;

public class MappingModel {

	private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

	public Product mappingModel(ProductDTO productDTO) {
		Product product = new Product();
		if (productDTO.getId() != null) {
			product.setId(productDTO.getId());
		}
		product.setTitle(productDTO.getTitle());
		/*
		 * product.setPrice(productDTO.getPrice());
		 * product.setPriceSale(productDTO.getPriceSale());
		 */ product.setDescription(productDTO.getDescription());
		product.setDetail(productDTO.getDetail());
		product.setSeo(productDTO.getSeo());
		product.setIsHot(productDTO.getIsHot());
		product.setStatus(productDTO.getStatus());
		/* product.setCategory(categoryService.getById(productDTO.getId_category())); */
		/* product.setAmount(productDTO.getAmount()); */
		product.setGuarantee(productDTO.getGuarantee());
		product.setOrigin(productDTO.getOrigin());
		product.setCreatedBy(productDTO.getCreatedBy());
		product.setUpdatedBy(productDTO.getUpdatedBy());
		product.setCreatedDate(productDTO.getCreatedDate());
		product.setUpdatedDate(productDTO.getUpdatedDate());
		return product;
	}

	public Category mappingModel(CategoryDTO categoryDTO) {
		Category category = new Category();
		if (categoryDTO.getId() != null) {
			category.setId(categoryDTO.getId());
		}
		category.setName(categoryDTO.getName());
		category.setDescription(categoryDTO.getDescription());
		category.setSeo(categoryDTO.getSeo());
		category.setStatus(categoryDTO.getStatus());
		category.setCreatedBy(categoryDTO.getCreatedBy());
		category.setUpdatedBy(categoryDTO.getUpdatedBy());
		category.setCreatedDate(categoryDTO.getCreatedDate());
		category.setUpdatedDate(categoryDTO.getUpdatedDate());
		category.setIsHot(categoryDTO.getIsHot());
		return category;
	}

	public CategoryBlog mappingModel(CategoryBlogDTO categoryBlogDTO) {
		CategoryBlog categoryBlog = new CategoryBlog();
		if (categoryBlogDTO.getId() != null) {
			categoryBlog.setId(categoryBlogDTO.getId());
		}
		categoryBlog.setStatus(categoryBlogDTO.getStatus());
		categoryBlog.setCreatedBy(categoryBlogDTO.getCreatedBy());
		categoryBlog.setUpdatedBy(categoryBlogDTO.getUpdatedBy());
		categoryBlog.setCreatedDate(categoryBlogDTO.getCreatedDate());
		categoryBlog.setUpdatedDate(categoryBlogDTO.getUpdatedDate());

		categoryBlog.setName(categoryBlogDTO.getName());
		categoryBlog.setSeo(categoryBlogDTO.getSeo());
		categoryBlog.setIsHot(categoryBlogDTO.getIsHot());
		return categoryBlog;
	}

	public Blog mappingModel(BlogDTO blogDTO) {
		Blog blog = new Blog();
		if (blogDTO.getId() != null) {
			blog.setId(blogDTO.getId());
		}
		blog.setStatus(blogDTO.getStatus());
		blog.setCreatedBy(blogDTO.getCreatedBy());
		blog.setUpdatedBy(blogDTO.getUpdatedBy());
		blog.setCreatedDate(blogDTO.getCreatedDate());
		blog.setUpdatedDate(blogDTO.getUpdatedDate());

		blog.setName(blogDTO.getName());
		blog.setSeo(blogDTO.getSeo());
		blog.setIsHot(blogDTO.getIsHot());
		blog.setDescription(blogDTO.getDescription());
		blog.setDetail(blogDTO.getDetail());
		return blog;
	}

	public Introduce mappingModel(IntroduceDTO introduceDTO) {
		Introduce introduce = new Introduce();
		if (introduce.getId() != null) {
			introduce.setId(introduceDTO.getId());
		}
		introduce.setStatus(introduceDTO.getStatus());
		introduce.setCreatedBy(introduceDTO.getCreatedBy());
		introduce.setUpdatedBy(introduceDTO.getUpdatedBy());
		introduce.setCreatedDate(introduceDTO.getCreatedDate());
		introduce.setUpdatedDate(introduceDTO.getUpdatedDate());
		introduce.setSeo(introduceDTO.getSeo());
		introduce.setDetail(introduceDTO.getDetail());
		return introduce;
	}

	public User mappingModel(UserDTO userDTO) {
		User user = new User();
		if (userDTO.getId() != null) {
			user.setId(userDTO.getId());
		}
		user.setStatus(userDTO.getStatus());
		user.setCreatedBy(userDTO.getCreatedBy());
		user.setUpdatedBy(userDTO.getUpdatedBy());
		user.setCreatedDate(userDTO.getCreatedDate());
		user.setUpdatedDate(userDTO.getUpdatedDate());

		user.setUsername(userDTO.getUsername());
		user.setPassword(userDTO.getPassword());
		user.setEmail(userDTO.getEmail());
		user.setFullname(userDTO.getFullname());
		user.setAddress(userDTO.getAddress());
		user.setPhone(userDTO.getPhone());
		return user;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(CategoryBlog categoryBlog) {
		JSONObject categotyBlogJson = new JSONObject();
		categotyBlogJson.put("id", categoryBlog.getId());
		categotyBlogJson.put("name", categoryBlog.getName());
		categotyBlogJson.put("seo", categoryBlog.getSeo());
		categotyBlogJson.put("avatar", categoryBlog.getAvatar());
		categotyBlogJson.put("status", categoryBlog.getStatus());
		categotyBlogJson.put("createdBy", categoryBlog.getCreatedBy());
		categotyBlogJson.put("updatedBy", categoryBlog.getUpdatedBy());
		categotyBlogJson.put("createdDate", categoryBlog.getCreatedDate());
		categotyBlogJson.put("updatedDate", categoryBlog.getUpdatedDate());
		categotyBlogJson.put("isHot", categoryBlog.getIsHot());
		return categotyBlogJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(Blog blog) {
		JSONObject blogJson = new JSONObject();
		blogJson.put("id", blog.getId());
		blogJson.put("name", blog.getName());
		blogJson.put("seo", blog.getSeo());
		blogJson.put("avatar", blog.getAvatar());
		blogJson.put("status", blog.getStatus());
		blogJson.put("createdBy", blog.getCreatedBy());
		blogJson.put("updatedBy", blog.getUpdatedBy());
		blogJson.put("createdDate", sdf.format(blog.getCreatedDate()));
		if (blog.getUpdatedDate() != null) {
			blogJson.put("updatedDate", sdf.format(blog.getUpdatedDate()));
		} else {
			blogJson.put("updatedDate", blog.getUpdatedDate());
		}
		blogJson.put("isHot", blog.getIsHot());
		blogJson.put("detail", blog.getDetail());
		blogJson.put("description", blog.getDescription());

		blogJson.put("id_category", blog.getCategoryBlog().getId());
		blogJson.put("categoryname", blog.getCategoryBlog().getName());

		return blogJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(RequestCancelOrder requestCancelOrder) {
		JSONObject requestJson = new JSONObject();
		requestJson.put("id", requestCancelOrder.getId());
		requestJson.put("status", requestCancelOrder.getStatus());
		requestJson.put("createdBy", requestCancelOrder.getCreatedBy());
		requestJson.put("updatedBy", requestCancelOrder.getUpdatedBy());
		requestJson.put("createdDate", sdf.format(requestCancelOrder.getCreatedDate()));
		if (requestCancelOrder.getUpdatedDate() != null) {
			requestJson.put("updatedDate", sdf.format(requestCancelOrder.getUpdatedDate()));
		} else {
			requestJson.put("updatedDate", requestCancelOrder.getUpdatedDate());
		}

		requestJson.put("firstName", requestCancelOrder.getFirstName());
		requestJson.put("lastName", requestCancelOrder.getLastName());
		requestJson.put("email", requestCancelOrder.getEmail());

		requestJson.put("requestType", requestCancelOrder.getRequestType());
		requestJson.put("reason", requestCancelOrder.getReason());
		requestJson.put("message", requestCancelOrder.getMessage());
		requestJson.put("id_order", requestCancelOrder.getSaleOrder().getId());
		requestJson.put("codeOrder", requestCancelOrder.getSaleOrder().getCode());
		return requestJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(Product product) {
		JSONObject productJson = new JSONObject();
		productJson.put("title", product.getTitle());
		productJson.put("description", product.getDescription());
		productJson.put("detail", product.getDetail());
		productJson.put("avatar", product.getAvatar());
		productJson.put("trademark", product.getTrademark());
		productJson.put("origin", product.getOrigin());
		productJson.put("guarantee", product.getGuarantee());
		productJson.put("isHot", product.getIsHot());
		productJson.put("id_category", product.getCategory().getId());
		productJson.put("fragrant", product.getFragrant());

		productJson.put("id", product.getId());
		productJson.put("status", product.getStatus());
		productJson.put("createdBy", product.getCreatedBy());
		productJson.put("updatedBy", product.getUpdatedBy());
		productJson.put("createdDate", product.getCreatedDate());
		productJson.put("updatedDate", product.getUpdatedDate());
		productJson.put("seo", product.getSeo());
		return productJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(ProductImage productImage) {
		JSONObject productJson = new JSONObject();
		productJson.put("id", productImage.getId());
		productJson.put("title", productImage.getTitle());
		productJson.put("path", productImage.getPath());
		productJson.put("status", productImage.getStatus());
		productJson.put("createdBy", productImage.getCreatedBy());
		productJson.put("updatedBy", productImage.getUpdatedBy());
		productJson.put("createdDate", productImage.getCreatedDate());
		productJson.put("updatedDate", productImage.getUpdatedDate());
		return productJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(Category category) {
		JSONObject productJson = new JSONObject();
		productJson.put("id", category.getId());
		productJson.put("name", category.getName());
		productJson.put("description", category.getDescription());
		productJson.put("seo", category.getSeo());
		productJson.put("avatar", category.getAvatar());
		/*
		 * if (category.getParent().getId()!=null) { productJson.put("parent",
		 * category.getParent().getId()); }
		 */
		productJson.put("status", category.getStatus());
		productJson.put("createdBy", category.getCreatedBy());
		productJson.put("updatedBy", category.getUpdatedBy());
		productJson.put("createdDate", category.getCreatedDate());
		productJson.put("updatedDate", category.getUpdatedDate());
		productJson.put("isHot", category.getIsHot());
		return productJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(User user) {
		JSONObject userJson = new JSONObject();
		userJson.put("id", user.getId());
		userJson.put("fullname", user.getFullname());
		userJson.put("username", user.getUsername());
		userJson.put("password", user.getPassword());
		userJson.put("email", user.getEmail());
		userJson.put("address", user.getAddress());
		userJson.put("phone", user.getPhone());
		userJson.put("avatar", user.getAvatar());

		userJson.put("status", user.getStatus());
		userJson.put("createdBy", user.getCreatedBy());
		userJson.put("updatedBy", user.getUpdatedBy());
		userJson.put("createdDate", user.getCreatedDate());
		userJson.put("updatedDate", user.getUpdatedDate());
		return userJson;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(Order saleOrder) {
		JSONObject saleOrderJSON = new JSONObject();

		saleOrderJSON.put("code", saleOrder.getCode());
		saleOrderJSON.put("total", saleOrder.getTotal());
		saleOrderJSON.put("customerName", saleOrder.getCustomerName());
		saleOrderJSON.put("customerAddress", saleOrder.getCustomerAddress());
		saleOrderJSON.put("customerPhone", saleOrder.getCustomerPhone());
		saleOrderJSON.put("customerEmail", saleOrder.getCustomerEmail());
		saleOrderJSON.put("seo", saleOrder.getSeo());
		saleOrderJSON.put("processingStatus", saleOrder.getProcessingStatus());
		saleOrderJSON.put("userID", saleOrder.getUserID());

		saleOrderJSON.put("id", saleOrder.getId());
		saleOrderJSON.put("status", saleOrder.getStatus());
		saleOrderJSON.put("createdBy", saleOrder.getCreatedBy());
		saleOrderJSON.put("updatedBy", saleOrder.getUpdatedBy());
		saleOrderJSON.put("createdDate", sdf.format(saleOrder.getCreatedDate()));
		if (saleOrder.getUpdatedDate() != null) {
			saleOrderJSON.put("updatedDate", sdf.format(saleOrder.getUpdatedDate()));
		} else {
			saleOrderJSON.put("updatedDate", saleOrder.getUpdatedDate());
		}

		return saleOrderJSON;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(OrderDetail saleOrderProduct) {
		JSONObject saleOrderProductJSON = new JSONObject();

		saleOrderProductJSON.put("avatar", saleOrderProduct.getProduct().getAvatar());
		saleOrderProductJSON.put("productName", saleOrderProduct.getProduct().getTitle());
		saleOrderProductJSON.put("quality", saleOrderProduct.getQuality());
		saleOrderProductJSON.put("price", saleOrderProduct.getPrice());

		saleOrderProductJSON.put("id", saleOrderProduct.getId());
		saleOrderProductJSON.put("status", saleOrderProduct.getStatus());
		saleOrderProductJSON.put("createdBy", saleOrderProduct.getCreatedBy());
		saleOrderProductJSON.put("updatedBy", saleOrderProduct.getUpdatedBy());
		saleOrderProductJSON.put("createdDate", sdf.format(saleOrderProduct.getCreatedDate()));
		if (saleOrderProduct.getUpdatedDate() != null) {
			saleOrderProductJSON.put("updatedDate", sdf.format(saleOrderProduct.getUpdatedDate()));
		} else {
			saleOrderProductJSON.put("updatedDate", saleOrderProduct.getUpdatedDate());
		}
		return saleOrderProductJSON;
	}

}
