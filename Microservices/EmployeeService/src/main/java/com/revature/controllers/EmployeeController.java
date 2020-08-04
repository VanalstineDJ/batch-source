package com.revature.controllers;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.intercom.ReimbursementClient;
import com.revature.models.Employee;
import com.revature.models.Reimbursement;

@RestController
@RequestMapping("/employees")
public class EmployeeController {

	private Logger log = Logger.getLogger(EmployeeController.class);
	
	private List<Employee> employees = new ArrayList<>();
	
	@Autowired
	ReimbursementClient reimbursementClient;

	public EmployeeController() {
		super();
		employees.add(new Employee(1, "Dan Stan", "dls30@gmail.com", null));
		employees.add(new Employee(2, "Master Lahm", "laahm16@gmail.com", null));
		employees.add(new Employee(3, "Lucas D'Angelo", "ltd20@gmail.com", null));
		employees.add(new Employee(4, "Jackie Bud", "jbud7@gmail.com", null));
		employees.add(new Employee(5, "Travis Woodz", "woodzie42@gmail.com", null));
	}
	
	@GetMapping
	public List<Employee> getAllEmployees(){
		log.info("getting all employees");
		return employees;
	}
	
	@GetMapping("/{employeeId}")
	public Employee getEmployeeById(@PathVariable("employeeId") Integer employeeId) {
		log.info("getting employee by id: " + employeeId);
		Employee employee = employees.stream()
				.filter(emp -> emp.getEmployeeId() == employeeId)
				.findFirst().get();
		List<Reimbursement> reimbursements = reimbursementClient.getReimbursementsByEmployeeId(employeeId);
		employee.setReimbursements(reimbursements);
		return employee;
	}
}