package com.revature.servlets;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.servlets.DefaultServlet;



public class FrontController extends DefaultServlet{
private static final long serialVersionUID = 1L;
    
	RequestHelper rh = new RequestHelper();
	
    public FrontController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getRequestURI().substring(request.getContextPath().length()));
		System.out.println(getServletContext().getInitParameter("myContextParam"));
		System.out.println(getServletConfig().getInitParameter("myConfigParam"));
		
		if(request.getRequestURI().substring(request.getContextPath().length()).startsWith("/static/")) {
			super.doGet(request, response);
		} else {
			//response.getWriter().append("Served at: ").append(request.getContextPath());	
			rh.process(request, response);
			System.out.println("hr handles");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}