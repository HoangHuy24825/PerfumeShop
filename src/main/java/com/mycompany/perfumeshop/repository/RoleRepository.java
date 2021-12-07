package com.mycompany.perfumeshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mycompany.perfumeshop.entities.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer>, JpaSpecificationExecutor<Role> {

	Role findByCode(String code);

	List<Role> findByStatus(Boolean status);

	Page<Role> findAll(Specification<Role> spec, Pageable pageable);
}
