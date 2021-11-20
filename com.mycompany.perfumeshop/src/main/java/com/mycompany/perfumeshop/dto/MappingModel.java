package com.mycompany.perfumeshop.dto;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;

import com.mycompany.perfumeshop.entities.AttributeProduct;
import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.entities.Category;
import com.mycompany.perfumeshop.entities.CategoryBlog;
import com.mycompany.perfumeshop.entities.Introduce;
import com.mycompany.perfumeshop.entities.Order;
import com.mycompany.perfumeshop.entities.OrderDetail;
import com.mycompany.perfumeshop.entities.Product;
import com.mycompany.perfumeshop.entities.ProductImage;
import com.mycompany.perfumeshop.entities.RequestCancelOrder;
import com.mycompany.perfumeshop.entities.Review;
import com.mycompany.perfumeshop.entities.User;

@Component
public class MappingModel {

	private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

	public Product mappingModel(ProductDTO productDTO) {
		Product product = new Product();
		if (productDTO.getId() != null) {
			product.setId(productDTO.getId());
		}
		product.setTitle(productDTO.getTitle());
		product.setDescription(productDTO.getDescription());
		product.setDetail(productDTO.getDetail());
		product.setTrademark(productDTO.getTrademark());
		product.setOrigin(productDTO.getOrigin());
		product.setManufactureYear(productDTO.getManufactureYear());
		product.setSeo(productDTO.getSeo());
		product.setFragrant(productDTO.getFragrant());
		product.setIsHot(productDTO.getIsHot());
		product.setStatus(productDTO.getStatus());
		product.setCreatedBy(productDTO.getCreatedBy());
		product.setUpdatedBy(productDTO.getUpdatedBy());
		product.setCreatedDate(productDTO.getCreatedDate());
		product.setUpdatedDate(productDTO.getUpdatedDate());

		List<AttributeProductDTO> attributeProductDTOs = productDTO.getListAttibute();
		for (AttributeProductDTO attributeProductDTO : attributeProductDTOs) {
			product.addAttribute(mappingModel(attributeProductDTO));
		}
		return product;
	}

	public AttributeProduct mappingModel(AttributeProductDTO attributeProductDTO) {
		AttributeProduct attributeProduct = new AttributeProduct();
		if (attributeProductDTO.getId() != null) {
			attributeProduct.setId(attributeProductDTO.getId());
		}
		attributeProduct.setCapacity(attributeProductDTO.getCapacity());
		attributeProduct.setPrice(attributeProductDTO.getPrice());
		attributeProduct.setPriceSale(attributeProductDTO.getPriceSale());
		attributeProduct.setStatus(attributeProductDTO.getStatus());
		attributeProduct.setCreatedBy(attributeProductDTO.getCreatedBy());
		attributeProduct.setUpdatedBy(attributeProductDTO.getUpdatedBy());
		attributeProduct.setCreatedDate(attributeProductDTO.getCreatedDate());
		attributeProduct.setUpdatedDate(attributeProductDTO.getUpdatedDate());
		attributeProduct.setAmount(attributeProductDTO.getAmount());
		return attributeProduct;
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

		requestJson.put("customerName", requestCancelOrder.getCustomerName());
		requestJson.put("email", requestCancelOrder.getEmail());

		requestJson.put("requestType", requestCancelOrder.getRequestType());
		requestJson.put("reason", requestCancelOrder.getReason());
		requestJson.put("message", requestCancelOrder.getMessage());
		requestJson.put("id_order", requestCancelOrder.getOrder().getId());
		requestJson.put("codeOrder", requestCancelOrder.getOrder().getCode());
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
		productJson.put("manufactureYear", product.getManufactureYear());
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
		productJson.put("reviews", product.getReviews());
		productJson.put("attrs", product.getAttributeProducts());
		productJson.put("images", product.getProductImages());
		productJson.put("maxPrice", maxPriceOfProduct(product.getAttributeProducts()));
		productJson.put("minPrice", minPriceOfProduct(product.getAttributeProducts()));
		productJson.put("starReviews", averageStar(product.getReviews()));
		return productJson;
	}

	private BigDecimal maxPriceOfProduct(List<AttributeProduct> attributeProducts) {
		BigDecimal maxPrice = (attributeProducts.get(0).getPriceSale() != null
				&& attributeProducts.get(0).getPriceSale() != BigDecimal.valueOf(0))
						? attributeProducts.get(0).getPriceSale()
						: attributeProducts.get(0).getPrice();
		for (AttributeProduct attributeProduct : attributeProducts) {
			if (attributeProduct.getPrice().compareTo(maxPrice) > 0 || (attributeProduct.getPriceSale() != null
					&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)
					&& attributeProduct.getPriceSale().compareTo(maxPrice) > 0)) {
				maxPrice = attributeProduct.getPrice();
			}
		}
		return maxPrice;
	}

	private BigDecimal minPriceOfProduct(List<AttributeProduct> attributeProducts) {
		BigDecimal minPrice = (attributeProducts.get(0).getPriceSale() != null
				&& attributeProducts.get(0).getPriceSale() != BigDecimal.valueOf(0))
						? attributeProducts.get(0).getPriceSale()
						: attributeProducts.get(0).getPrice();
		for (AttributeProduct attributeProduct : attributeProducts) {
			if (attributeProduct.getPrice().compareTo(minPrice) < 0 || (attributeProduct.getPriceSale() != null
					&& attributeProduct.getPriceSale() != BigDecimal.valueOf(0)
					&& attributeProduct.getPriceSale().compareTo(minPrice) < 0)) {
				minPrice = attributeProduct.getPrice();
			}
		}
		return minPrice;
	}

	private Double averageStar(List<Review> reviews) {
		Double totalStar = 0.0;
		Double result = 0.0;
		for (Review review : reviews) {
			totalStar += review.getNumberStar();
		}
		if (totalStar != 0) {
			result = (double) Math.round((totalStar / reviews.size() * 10) / 10);
		}
		return result;
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
	public JSONObject mappingModel(AttributeProduct attributeProduct) {
		JSONObject productAttributeJson = new JSONObject();
		productAttributeJson.put("id", attributeProduct.getId());
		productAttributeJson.put("capacity", attributeProduct.getCapacity());
		productAttributeJson.put("price", attributeProduct.getPrice());
		productAttributeJson.put("priceSale", attributeProduct.getPriceSale());
		productAttributeJson.put("amount", attributeProduct.getAmount());
		productAttributeJson.put("createdBy", attributeProduct.getCreatedBy());
		productAttributeJson.put("updatedBy", attributeProduct.getUpdatedBy());
		productAttributeJson.put("createdDate", attributeProduct.getCreatedDate());
		productAttributeJson.put("updatedDate", attributeProduct.getUpdatedDate());
		return productAttributeJson;
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
	public JSONObject mappingModel(Order order) {
		JSONObject orderJSON = new JSONObject();

		orderJSON.put("code", order.getCode());
		orderJSON.put("total", order.getTotal());
		orderJSON.put("customerName", order.getCustomerName());
		orderJSON.put("customerAddress", order.getCustomerAddress());
		orderJSON.put("customerPhone", order.getCustomerPhone());
		orderJSON.put("customerEmail", order.getCustomerEmail());
		orderJSON.put("seo", order.getSeo());
		orderJSON.put("processingStatus", order.getProcessingStatus());
		orderJSON.put("userID", order.getUserID());
		List<OrderDetail> details = order.getOrderDetails();
		List<JSONObject> orderDetails = new ArrayList<JSONObject>();
		details.forEach(d -> orderDetails.add(mappingModel(d)));
		orderJSON.put("orderDetails", orderDetails);

		orderJSON.put("id", order.getId());
		orderJSON.put("status", order.getStatus());
		orderJSON.put("createdBy", order.getCreatedBy());
		orderJSON.put("updatedBy", order.getUpdatedBy());
		orderJSON.put("createdDate", sdf.format(order.getCreatedDate()));
		orderJSON.put("updatedDate", order.getUpdatedDate() != null ? sdf.format(order.getUpdatedDate()) : "");
		return orderJSON;
	}

	@SuppressWarnings("unchecked")
	public JSONObject mappingModel(OrderDetail orderDetail) {
		JSONObject orderDetailJSON = new JSONObject();
		orderDetailJSON.put("avatar", orderDetail.getAttributeProduct().getProduct().getAvatar());
		orderDetailJSON.put("productName", orderDetail.getAttributeProduct().getProduct().getTitle());
		orderDetailJSON.put("quantity", orderDetail.getQuantity());
		orderDetailJSON.put("price", orderDetail.getPrice());
		orderDetailJSON.put("id", orderDetail.getId());
		orderDetailJSON.put("status", orderDetail.getStatus());
		orderDetailJSON.put("createdBy", orderDetail.getCreatedBy());
		orderDetailJSON.put("updatedBy", orderDetail.getUpdatedBy());
		orderDetailJSON.put("createdDate", sdf.format(orderDetail.getCreatedDate()));
		orderDetailJSON.put("updatedDate",
				orderDetail.getUpdatedDate() != null ? sdf.format(orderDetail.getUpdatedDate()) : "");
		return orderDetailJSON;
	}

}
