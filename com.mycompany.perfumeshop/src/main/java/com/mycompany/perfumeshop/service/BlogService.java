package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

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
import com.mycompany.perfumeshop.entities.Blog;
import com.mycompany.perfumeshop.repository.BlogRepository;
import com.mycompany.perfumeshop.request.UserRequest;
import com.mycompany.perfumeshop.specification.BlogSpecification;
import com.mycompany.perfumeshop.utils.Constants;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Service
@Transactional
public class BlogService extends BaseService<Blog> {

	@Override
	protected Class<Blog> clazz() {
		return Blog.class;
	}

	@Autowired
	private GlobalConfig globalConfig;

	@Autowired
	private BlogRepository blogRepository;

	@Autowired
	private BlogSpecification blogSprecification;

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	public Blog save(Blog blog, MultipartFile avatar) throws Exception {
		if (!isEmptyUploadFile(avatar)) {
			avatar.transferTo(new File(globalConfig.getUploadRootPath() + "blog/" + avatar.getOriginalFilename()));
			blog.setAvatar("blog/" + avatar.getOriginalFilename());
		}
		blog.setSeo(new Slugify().slugify(blog.getName()));
		blog.setCreatedDate(Calendar.getInstance().getTime());
		return blogRepository.save(blog);
	}

	public Blog edit(Blog blog, MultipartFile avatar) throws Exception {
		Optional<Blog> oldBlog = blogRepository.findById(blog.getId());
		if (!isEmptyUploadFile(avatar)) {
			new File(globalConfig.getUploadRootPath() + oldBlog.get().getAvatar()).delete();
			avatar.transferTo(new File(globalConfig.getUploadRootPath() + "blog/" + avatar.getOriginalFilename()));
			blog.setAvatar("blog/" + avatar.getOriginalFilename());
		} else {
			blog.setAvatar(oldBlog.get().getAvatar());
		}
		blog.setSeo(new Slugify().slugify(blog.getName()));
		blog.setCreatedDate(oldBlog.get().getCreatedDate());
		blog.setCreatedBy(oldBlog.get().getCreatedBy());
		blog.setUpdatedDate(Calendar.getInstance().getTime());
		return blogRepository.save(blog);
	}

	public Boolean deleteBlogById(Integer idBlog) {
		Optional<Blog> blog = blogRepository.findById(idBlog);
		new File(globalConfig.getUploadRootPath() + blog.get().getAvatar()).delete();
		blogRepository.delete(blog.get());
		return true;
	}

	public BaseVo<Blog> getListBlogByFilter(UserRequest userRequest) {
		if (userRequest.getKeySearch() == null) {
			userRequest.setKeySearch(Constants.STR_EMPTY);
		}
		Pageable pageable = PageRequest.of(userRequest.getCurrentPage() - 1, userRequest.getSizeOfPage(),
				Sort.by("createdDate").descending().and(Sort.by("updatedDate").descending()));
		BaseVo<Blog> baseVo = new BaseVo<Blog>();
		Page<Blog> page = blogRepository.findAll(blogSprecification.findBlog(userRequest), pageable);
		baseVo.setListEntity(page.getContent());
		baseVo.setCurrentPage(page.getNumber() + 1);
		baseVo.setTotalPage(page.getTotalPages());
		return baseVo;
	}

	public List<Blog> getRecentPost() {
		return blogRepository.findTop5ByOrderByCreatedDateDescUpdatedDateDesc();
	}
}
