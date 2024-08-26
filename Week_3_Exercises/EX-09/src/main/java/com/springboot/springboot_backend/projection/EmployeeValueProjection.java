package com.springboot.springboot_backend.projection;

import org.springframework.beans.factory.annotation.Value;

public interface EmployeeValueProjection {

    @Value("#{target.id}")
    Long getId();

    @Value("#{target.name}")
    String getName();

    @Value("#{target.email}")
    String getEmail();

    @Value("#{target.department.name}")
    String getDepartmentName();
}
