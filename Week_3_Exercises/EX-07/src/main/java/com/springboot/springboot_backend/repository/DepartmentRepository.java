package com.springboot.springboot_backend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.springboot_backend.model.Department;

public interface DepartmentRepository extends JpaRepository<Department, Long> {

    // Custom query method to find departments whose name contains a specific string
    List<Department> findByNameContaining(String name);
}
