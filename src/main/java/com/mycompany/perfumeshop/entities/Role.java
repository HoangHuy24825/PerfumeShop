package com.mycompany.perfumeshop.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_roles")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Role extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(name = "name", length = 45, nullable = false)
	private String name;

	@Column(name = "code", length = 255, nullable = true)
	private String code;

	@Column(name = "description", length = 45, nullable = false)
	private String description;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "role")
	private List<UserRole> userRoles = new ArrayList<UserRole>();

	public void addUserRole(UserRole userRole) {
		userRoles.add(userRole);
		userRole.setRole(this);
	}

	public void deleteUserRole(UserRole userRole) {
		userRoles.remove(userRole);
		userRole.setRole(null);
	}

}
