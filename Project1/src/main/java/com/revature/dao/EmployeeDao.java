package com.revature.dao;

import java.util.List;

import com.revature.company.Employee;

public interface EmployeeDao {

	// the methods to be used to retrieve the employees from the database
	public List<Employee> getAllEmployees();
	public Employee getEmployeeById(String id);
	public Employee getEmployeeByNAme(String firstname, String lastname);
	public int addNewEmployee(Employee e);
	
	
}