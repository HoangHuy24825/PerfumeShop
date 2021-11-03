package com.mycompany.perfumeshop.entities;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class User extends BaseEntity implements UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(name = "username", length = 45, nullable = false)
	private String username;

	@Column(name = "password", length = 100, nullable = false)
	private String password;

	@Column(name = "email", length = 45, nullable = false)
	private String email;

	@Column(name = "full_name", length = 60, nullable = false)
	private String fullname;

	@Column(name = "address", length = 255, nullable = true)
	private String address;

	@Column(name = "phone", length = 15, nullable = false)
	private String phone;

	@Column(name = "avatar", length = 255, nullable = false)
	private String avatar;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "user")
	private List<UserRole> userRoles = new ArrayList<UserRole>();

	public void addUserRole(UserRole userRole) {
		userRoles.add(userRole);
		userRole.setUser(this);
	}

	public void deleteUserRole(UserRole userRole) {
		userRoles.remove(userRole);
		userRole.setUser(null);
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	private List<Review> reviews = new ArrayList<>();

	public void addUserReview(Review review) {
		reviews.add(review);
		review.setUser(this);
	}

	public void deleteReview(Review review) {
		reviews.remove(review);
		review.setUser(null);
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	private List<Notify> notifies = new ArrayList<>();

	public void addNotify(Notify notify) {
		notifies.add(notify);
		notify.setUser(this);
	}

	public void deleteNotify(Notify notify) {
		notifies.remove(notify);
		notify.setUser(null);
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return userRoles;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

}
