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
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.perfumeshop.dto.Constant;
import com.mycompany.perfumeshop.entities.Role;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;
import com.mycompany.perfumeshop.valueObjects.BaseVo;

@Service
public class UserService extends BaseService<User> implements Constant {

	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	private UserRoleService userRoleService;

	@Autowired
	private RoleService roleService;

	@Override
	protected Class<User> clazz() {
		return User.class;
	}

	@SuppressWarnings("unchecked")
	public User getUserByUserName(String username) {
		Query query = entityManager.createQuery("FROM User u WHERE u.username=:username");
		query.setParameter("username", username);
		List<User> users = query.getResultList();
		return users.size() != 0 ? users.get(0) : new User();
	}

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	@Transactional
	public User save(User user, MultipartFile avatar, Integer typeAccount) throws Exception {
		if (!isEmptyUploadFile(avatar)) {
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "user/" + avatar.getOriginalFilename()));
			user.setAvatar("user/" + avatar.getOriginalFilename());
		}
		user.setCreatedDate(Calendar.getInstance().getTime());
		user.setStatus(true);
		user.setPassword(new BCryptPasswordEncoder().encode((user.getPassword())));
		User result = super.saveOrUpdate(user);
		UserRole userRole = null;

		if (typeAccount == 1) {
			List<Role> roles = roleService.findAll();
			for (Role role : roles) {
				if (!role.getCode().equalsIgnoreCase("SA") && !role.getCode().equalsIgnoreCase("G")) {
					userRole = new UserRole();
					userRole.setUser(user);
					userRole.setRole(role);
					userRole.setDelete(false);
					userRole.setInsert(false);
					userRole.setView(true);
					userRole.setUpdate(false);
					userRole.setStatus(true);
					userRole.setRoleName("ADMIN_S");
					userRoleService.saveOrUpdate(userRole);
				}
			}
		} else {
			Role role = roleService.getRoleByCode("G");
			userRole = new UserRole();
			userRole.setUser(user);
			userRole.setRole(role);
			userRole.setDelete(false);
			userRole.setInsert(false);
			userRole.setView(true);
			userRole.setUpdate(false);
			userRole.setStatus(true);
			userRole.setRoleName("GUEST");
			userRoleService.saveOrUpdate(userRole);
		}
		return result;
	}

	@Transactional
	public User edit(User user, MultipartFile avatar) throws Exception {

		User oldUser = super.getById(user.getId());

		if (!isEmptyUploadFile(avatar)) {
			new File(UPLOAD_ROOT_PATH + oldUser.getAvatar()).delete();
			avatar.transferTo(new File(UPLOAD_ROOT_PATH + "user/" + avatar.getOriginalFilename()));
			user.setAvatar("user/" + avatar.getOriginalFilename());
		} else {
			user.setAvatar(oldUser.getAvatar());
		}
		if (user.getStatus() == null) {
			user.setStatus(true);
		}
		user.setUpdatedDate(Calendar.getInstance().getTime());
		user.setCreatedDate(oldUser.getCreatedDate());
		user.setCreatedBy(oldUser.getCreatedBy());
		return super.saveOrUpdate(user);
	}

	@SuppressWarnings("unchecked")
	public BaseVo<User> getListUserByRole(Integer role, Integer page, Integer pageSize, Integer currentID) {
		try {
			CriteriaBuilder builder = entityManager.getCriteriaBuilder();
			CriteriaQuery<User> criteriaQuery = builder.createQuery(User.class);
			Root<User> root = criteriaQuery.from(User.class);
			Join<User, UserRole> fromUserRole = root.join("userRoles");
			Join<UserRole, Role> fromRoleUserRole = fromUserRole.join("role");

			criteriaQuery.select(root);

			List<Predicate> predicates = new ArrayList<Predicate>();

			predicates.add(builder.notEqual(root.get("id"), currentID));

			if (role == 0) {
				predicates.add(builder.notEqual(fromRoleUserRole.get("code"), "G"));
				predicates.add(builder.notEqual(root.get("username"), "admin"));
			} else {
				predicates.add(builder.equal(fromRoleUserRole.get("code"), "G"));
			}

			criteriaQuery.where(predicates.toArray(new Predicate[] {}));
			criteriaQuery.groupBy(fromUserRole.get("user"));
			criteriaQuery.orderBy(builder.desc(root.get("createdDate")), builder.desc(root.get("updatedDate")));

			Query query = entityManager.createQuery(criteriaQuery);

			int totalRecs = query.getResultList().size();
			int totalPage = totalRecs / pageSize;
			totalPage = totalRecs % pageSize == 0 ? totalPage : totalPage + 1;
			query.setFirstResult((page - 1) * pageSize);
			query.setMaxResults(pageSize);

			BaseVo<User> baseVo = new BaseVo<User>();
			baseVo.setListEntity(query.getResultList());
			baseVo.setCurrentPage(page);
			baseVo.setTotalPage(totalPage);

			return baseVo;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public User getUserByEmail(String email) {
		Query query = entityManager.createQuery("FROM User u where u.email=:email");
		query.setParameter("email", email);
		List<User> listUser = query.getResultList();
		return listUser.size() != 0 ? listUser.get(0) : null;
	}

}
