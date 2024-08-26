package com.springboot.springboot_backend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.springboot_backend.model.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    // Derived query method to find employees by name
    List<Employee> findByName(String name);

    // Derived query method to find employees by department ID
    List<Employee> findByDepartmentId(Long departmentId);

    void clear();
}