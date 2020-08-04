package com.revature.dao.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.revature.company.Department;
import com.revature.company.Employee;
import com.revature.dao.DepartmentDao;
import com.revature.dao.EmployeeDao;
import com.revature.util.ConnectionUtil;

public class EmployeeDaoImpl implements EmployeeDao {
	
	DepartmentDao deptDao = new DepartmentDaoImpl();

	@Override
	public List<Employee> getAllEmployees() {
		List<Employee> employees = new ArrayList<>();

		String sql = "SELECT * FROM EMPLOYEES";

		try (Connection c = ConnectionUtil.getConnection();
				Statement s = c.createStatement();
				ResultSet rs = s.executeQuery(sql)) {

			while (rs.next()) {
				int empId = rs.getInt("EMP_ID");
				int deptId = rs.getInt("DEPT_ID");
				String firstName = rs.getString("EMP_FIRSTNAME");
				String lastName = rs.getString("EMP_LASTNAME");
				String email = rs.getString("EMP_EMAIL");
				String username = rs.getString("EMP_USERNAME");
				String password = rs.getString("EMP_PASS");
				employees.add(new Employee(empId, firstName, lastName, email, username, password, new Department(deptId)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(employees);
		return employees;
	}

	@Override
	public Employee getEmployeeById(int id) {
		String sql = "SELECT * FROM EMPLOYEES WHERE EMP_ID = ?";
		Employee e = null;
		
		try(Connection c = ConnectionUtil.getConnection();
				PreparedStatement ps = c.prepareStatement(sql)){
			
			ps.setInt(1,  id);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				int empId = rs.getInt("EMP_ID");
				int deptId = rs.getInt("DEPT_ID");
				String firstName = rs.getString("EMP_FIRSTNAME");
				String lastName = rs.getString("EMP_LASTNAME");
				String email = rs.getString("EMP_EMAIL");
				String username = rs.getString("EMP_USERNAME");
				String password = rs.getString("EMP_PASS");
				e = new Employee(empId, firstName, lastName, email, username, password, new Department(deptId));
			}
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}	
		return e;
	}
	
	@Override
	public Employee getEmployeeByName(String firstname, String lastname) {
		String sql = "SELECT * FROM EMPLOYEES WHERE EMP_FIRSTNAME = ? AND EMP_LASTNAME =?";
		Employee emp = null;
		
		try(Connection c = ConnectionUtil.getConnection();
				PreparedStatement ps = c.prepareStatement(sql)){
			
			ps.setString(1,  firstname);
			ps.setString(2, lastname);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				int empId = rs.getInt("EMP_ID");
				int deptId = rs.getInt("DEPT_ID");
				String firstName = rs.getString("EMP_FIRSTNAME");
				String lastName = rs.getString("EMP_LASTNAME");
				String email = rs.getString("EMP_EMAIL");
				String empUsername = rs.getString("EMP_USERNAME");
				String password = rs.getString("EMP_PASS");
				emp = new Employee(empId, firstName, lastName, email, empUsername, password, new Department(deptId));
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return emp;
	}

	@Override
	public Employee getEmployeeByUsername(String username) {
		String sql = "SELECT * FROM EMPLOYEES WHERE EMP_USERNAME = ?";
		Employee emp = null;
		
		try(Connection c = ConnectionUtil.getConnection();
				PreparedStatement ps = c.prepareStatement(sql)){
			
			ps.setString(1,  username);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				int empId = rs.getInt("EMP_ID");
				int deptId = rs.getInt("DEPT_ID");
				String firstName = rs.getString("EMP_FIRSTNAME");
				String lastName = rs.getString("EMP_LASTNAME");
				String email = rs.getString("EMP_EMAIL");
				String empUsername = rs.getString("EMP_USERNAME");
				String password = rs.getString("EMP_PASS");
				emp = new Employee(empId, firstName, lastName, email, empUsername, password, new Department(deptId));
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return emp;
	}

	@Override
	public int addNewEmployee(Employee emp) {
		int employeesAdded = 0;
		String sql = "INSERT INTO EMPLOYEES ("
				+ "EMP_ID, "
				+ "DEPT_ID, "
				+ "EMP_FIRSTNAME, "
				+ "EMP_LASTNAME, "
				+ "EMP_EMAIL, "
				+ "EMP_USERNAME, "
				+ "EMP_PASS) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		try(Connection c = ConnectionUtil.getConnection();
				PreparedStatement ps = c.prepareStatement(sql)){
			
				ps.setInt(1, emp.getEmpId());
				ps.setInt(2, emp.getD().getDeptId());
				ps.setString(3, emp.getFirstName());
				ps.setString(4, emp.getLastName());
				ps.setString(5, emp.getEmail());
				ps.setString(6, emp.getUsername());
				ps.setString(7, emp.getPassword());
				employeesAdded = ps.executeUpdate();
				
		} catch (SQLException e) {
			e.printStackTrace();
		}			
		return employeesAdded;
	}

	@Override
	public int updateEmployee(Employee emp) {
		int employeesUpdated = 0;
		String sql = "UPDATE EMPLOYEE "
				+ "SET "
				+ "EMP_ID = ?, DEPT_ID = ?, EMP_FIRSTNAME = ?, EMP_LASTNAME = ?, EMP_EMAIL = ?, EMP_USERNAME = ?, EMP_PASS = ?";
		
		try(Connection c = ConnectionUtil.getConnection();
				PreparedStatement ps = c.prepareStatement(sql)){
			
			ps.setInt(1, emp.getEmpId());
			ps.setInt(2, emp.getD().getDeptId());
			ps.setString(3, emp.getFirstName());
			ps.setString(4, emp.getLastName());
			ps.setString(5, emp.getEmail());
			ps.setString(6, emp.getUsername());
			ps.setString(7, emp.getPassword());
			employeesUpdated = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return employeesUpdated;
	}

	@Override
	public int deleteEmployee(int id) {
		int employeesDeleted = 0;
		
		String sql = "DELETE FROM EMPLOYEES WHERE EMP_ID = ?";
		
		try(Connection c = ConnectionUtil.getConnection();
				PreparedStatement ps = c.prepareStatement(sql)){
			
			ps.setInt(1, id);
			employeesDeleted = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return employeesDeleted;
	}
}