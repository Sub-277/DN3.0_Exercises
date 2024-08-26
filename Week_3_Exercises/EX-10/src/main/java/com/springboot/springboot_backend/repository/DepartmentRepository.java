package com.springboot.springboot_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.springboot_backend.model.Department;

public interface DepartmentRepository extends JpaRepository<Department, Long> {

    // Derived query method to find departments by name
    Department findByName(String name);
}
