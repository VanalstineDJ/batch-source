package delegates;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import models.Employee;
import models.Reimbursements;
import services.ReimbursementService;

public class ReimbursementDelegate {

	ReimbursementService reimbService = new ReimbursementService();
	
	public void getReimbursements(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ObjectMapper om = new ObjectMapper();
		String reimbursementsJSON;
		
		List<Reimbursements> reimbursements = reimbService.getReimbursements();
		
		reimbursementsJSON = om.writeValueAsString(reimbursements);
		
		PrintWriter pw = response.getWriter();
		pw.write(reimbursementsJSON);
		pw.close();
		
	}
	
	public void resolveReimbursements(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String requestBodyText = request.getReader().readLine();
		
		ObjectMapper om = new ObjectMapper();
		Reimbursements newReim = om.readValue(requestBodyText, Reimbursements.class);
		
		int reimbursementsUpdated = reimbService.resolveReimbursements(newReim);
		if (reimbursementsUpdated == 1) {
			response.setStatus(201);
		} else {
			response.setStatus(400);
		}
	}
}
