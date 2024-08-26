package com.springboot.springboot_backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.springboot.springboot_backend.model.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    // Custom query method to find an employee by email
    Optional<Employee> findByEmail(String email);

    // Custom query method using @Query to find employees by department name
    @Query("SELECT e FROM Employee e WHERE e.department.name = :departmentName")
    List<Employee> findByDepartmentName(@Param("departmentName") String departmentName);
}
