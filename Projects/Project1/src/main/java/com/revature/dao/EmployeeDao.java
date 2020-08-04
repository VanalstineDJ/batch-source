package com.revature.dao;

import java.util.List;

import com.revature.company.Employee;

public interface EmployeeDao {

	// the methods to be used to retrieve the employees from the database
	public List<Employee> getAllEmployees();
	public Employee getEmployeeById(int id);
	public Employee getEmployeeByName(String firstname, String lastname);
	public Employee getEmployeeByUsername(String username);
	public int addNewEmployee(Employee e);
	public int updateEmployee(Employee e);
	public int deleteEmployee(int id);	
}