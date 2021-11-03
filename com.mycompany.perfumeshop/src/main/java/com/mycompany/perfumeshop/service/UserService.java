package com.mycompany.perfumeshop.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.perfumeshop.dto.Constant;
import com.mycompany.perfumeshop.entities.Role;
import com.mycompany.perfumeshop.entities.User;
import com.mycompany.perfumeshop.entities.UserRole;

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

	public User getUserByUserName(String username) {
		List<User> users = super.executeNativeSql(
				"SELECT * FROM electronicdeviceshop.tbl_users where status=1 and username='" + username + "'");
		if (users.size() == 0) {
			return new User();
		}
		return users.get(0);
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
	public List<User> getListUserByRole(Integer role, Integer page, Integer pageSize, Integer currentID) {
		try {
			StringBuilder strQuery = new StringBuilder("");
			if (role == 0) {
				strQuery.append(
						"SELECT u.id,u.username,u.password,u.email,u.created_date,u.updated_date,u.updated_by,u.created_by,u.status,u.full_name,u.address,u.phone,u.avatar");
				strQuery.append("			FROM electronicdeviceshop.tbl_users u ");
				strQuery.append(
						"				INNER JOIN electronicdeviceshop.tbl_users_roles u_r ON u.id=u_r.user_id");
				strQuery.append("				INNER JOIN electronicdeviceshop.tbl_roles r ON u_r.role_id=r.id");
				strQuery.append("			WHERE r.code!='G' AND u.username!='admin' AND u.id!=" + currentID);
				strQuery.append(
						"			GROUP BY u.id,u.username,u.password,u.email,u.created_date,u.updated_date,u.updated_by,u.created_by,u.status,u.full_name,u.address,u.phone,u.avatar");
				strQuery.append("			ORDER BY updated_date DESC,created_date DESC");

			} else {
				strQuery.append(
						"SELECT u.id,u.username,u.password,u.email,u.created_date,u.updated_date,u.updated_by,u.created_by,u.status,u.full_name,u.address,u.phone,u.avatar");
				strQuery.append("			FROM electronicdeviceshop.tbl_users u ");
				strQuery.append(
						"				INNER JOIN electronicdeviceshop.tbl_users_roles u_r ON u.id=u_r.user_id");
				strQuery.append("				INNER JOIN electronicdeviceshop.tbl_roles r ON u_r.role_id=r.id");
				strQuery.append("			WHERE r.code='G' AND u.id!=" + currentID);
				strQuery.append(
						"			GROUP BY u.id,u.username,u.password,u.email,u.created_date,u.updated_date,u.updated_by,u.created_by,u.status,u.full_name,u.address,u.phone,u.avatar");
				strQuery.append("			ORDER BY updated_date DESC,created_date DESC");
			}
			Query query = entityManager.createNativeQuery(strQuery.toString(), User.class);
			query.setFirstResult((page - 1) * pageSize);
			query.setMaxResults(pageSize);
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<User>();
	}

	public Integer getTotalPageUserByRole(Integer role, Integer pageSize, Integer currentID) {
		try {
			StringBuilder strQuery = new StringBuilder("");
			if (role == 0) {
				strQuery.append(
						"SELECT u.id,u.username,u.password,u.email,u.created_date,u.updated_date,u.updated_by,u.created_by,u.status,u.full_name,u.address,u.phone,u.avatar");
				strQuery.append(" FROM electronicdeviceshop.tbl_users u ");
				strQuery.append(" INNER JOIN electronicdeviceshop.tbl_users_roles u_r ON u.id=u_r.user_id");
				strQuery.append(" INNER JOIN electronicdeviceshop.tbl_roles r ON u_r.role_id=r.id");
				strQuery.append(" WHERE r.code!='G'AND u.username!='admin' AND u.id!=" + currentID);
				strQuery.append(" ORDER BY updated_date DESC,created_date DESC");

			} else {
				strQuery.append(
						"SELECT u.id,u.username,u.password,u.email,u.created_date,u.updated_date,u.updated_by,u.created_by,u.status,u.full_name,u.address,u.phone,u.avatar");
				strQuery.append("			FROM electronicdeviceshop.tbl_users u ");
				strQuery.append(
						"				INNER JOIN electronicdeviceshop.tbl_users_roles u_r ON u.id=u_r.user_id");
				strQuery.append("				INNER JOIN electronicdeviceshop.tbl_roles r ON u_r.role_id=r.id");
				strQuery.append("			WHERE r.code='G' AND u.id!=" + currentID);
				strQuery.append("			ORDER BY updated_date DESC,created_date DESC");
			}
			Integer totalRecord = entityManager.createNativeQuery(strQuery.toString(), User.class).getResultList()
					.size();
			return totalRecord % pageSize == 0 ? totalRecord / pageSize : totalRecord / pageSize + 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public User getUserByEmail(String email) {
		List<User> listUser = super.executeNativeSql(
				"SELECT * FROM electronicdeviceshop.tbl_users where email='" + email + "'");
		return listUser.size() != 0 ? listUser.get(0) : null;
	}

}
