package com.revature.delegate;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.revature.models.Reimbursement;
import com.revature.services.ReimbursementService;

public class ReimbursementDelegate {
	ReimbursementService rService = new ReimbursementService();
	
	public void getReimbursements(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
	}
	public void createReimbursement(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String requestBodyText = request.getReader().readLine();
		
		ObjectMapper om = new ObjectMapper();
		Reimbursement newR = om.readValue(requestBodyText, Reimbursement.class);
		
		int reimbursementsCreated = rService.create(newR);
		if(reimbursementsCreated == 1) {
			response.setStatus(201);
		}
		else {
			response.setStatus(400);
		}
		
	}
	public void updateReimbursement(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
	}
	public void deleteReimbursement(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
	}
}
