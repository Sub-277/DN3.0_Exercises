package com.springboot.springboot_backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.springboot.springboot_backend.model.Employee;
import com.springboot.springboot_backend.projection.EmployeeDto;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    Optional<Employee> findByEmail(String email);

    @Query("SELECT new com.springboot.springboot_backend.projection.EmployeeDto(e.id, e.name, e.email, e.department.name) FROM Employee e WHERE e.department.name = :departmentName")
    List<EmployeeDto> findEmployeeDtosByDepartmentName(@Param("departmentName") String departmentName);

    Page<Employee> findAll(Pageable pageable);
}
