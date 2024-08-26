package com.springboot.springboot_backend.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.springboot_backend.model.Employee;
import com.springboot.springboot_backend.repository.EmployeeRepository;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Transactional
    public void batchSaveEmployees(List<Employee> employees) {
        int batchSize = 30;
        for (int i = 0; i < employees.size(); i++) {
            employeeRepository.save(employees.get(i));
            if (i % batchSize == 0 && i > 0) {
                // Flush a batch of inserts and release memory
                employeeRepository.flush();
                // Clear the persistence context
                employeeRepository.clear();
            }
        }
    }
}
