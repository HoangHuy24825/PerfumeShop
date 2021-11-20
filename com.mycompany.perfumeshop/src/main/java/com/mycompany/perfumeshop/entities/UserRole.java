package com.mycompany.perfumeshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_users_roles")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserRole extends BaseEntity implements GrantedAuthority {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(name = "role_name", length = 255, nullable = false)
	private String roleName;

	@Column(name = "insert_role", nullable = true)
	private Boolean insert = Boolean.FALSE;

	@Column(name = "update_role", nullable = true)
	private Boolean update = Boolean.FALSE;

	@Column(name = "view_role", nullable = true)
	private Boolean view = Boolean.FALSE;

	@Column(name = "delete_role", nullable = true)
	private Boolean delete = Boolean.FALSE;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "role_id")
	private Role role;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User user;

	@Override
	public String getAuthority() {
		return roleName;
	}

}
