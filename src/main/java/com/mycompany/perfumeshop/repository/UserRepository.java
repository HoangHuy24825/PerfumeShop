package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer>, JpaSpecificationExecutor<User> {

	User findByUsername(String username);

	User findByEmail(String email);

	List<User> findByStatus(Boolean status);

	Page<User> findAll(Specification<User> spec, Pageable pageable);

	User findByUsernameAndEmail(String userName, String email);

	User findByUsernameAndStatus(String userName, Boolean status);
}
