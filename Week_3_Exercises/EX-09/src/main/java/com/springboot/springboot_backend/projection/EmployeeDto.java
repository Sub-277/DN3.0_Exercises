package com.springboot.springboot_backend.projection;

import lombok.Data;

@Data
public class EmployeeDto {

    private Long id;
    private String name;
    private String email;
    private String departmentName;

    public EmployeeDto(Long id, String name, String email, String departmentName) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.departmentName = departmentName;
    }
}
