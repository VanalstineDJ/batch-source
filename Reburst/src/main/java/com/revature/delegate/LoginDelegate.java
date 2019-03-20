package com.revature.delegate;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.revature.service.LoginService;

public class LoginDelegate {

	LoginService loginService = new LoginService();
	
	public void checkLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
	String email = request.getParameter("username");
	System.out.println(email);
	String password = request.getParameter("password");
	System.out.println(password);
	String inputValidation = loginService.validation(email, password);
	System.out.println(inputValidation);
	request.setAttribute("message", inputValidation);
	
	

	if("nullEmail".matches(inputValidation) || "incorrect".matches("inputValidation")) {
		response.sendRedirect("login");
	} else {
		if("manager".matches(inputValidation)) {
			System.out.println(inputValidation);
			HttpSession session = request.getSession();
			session.setAttribute("email", email);
			response.sendRedirect("http://localhost:8080/EmployeePortal/managerLogin");
		} else if("hrmanager".matches(inputValidation)){
			HttpSession session = request.getSession();
			session.setAttribute("email", email);
			response.sendRedirect("http://localhost:8080/EmployeePortal/hrmanagerLogin");
		}else {
			HttpSession session = request.getSession();
			session.setAttribute("email", email);
			response.sendRedirect("http://localhost:8080/EmployeePortal/employee");
		}
			
		}		
	}
	}
