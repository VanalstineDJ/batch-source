window.onload = function(){
	document.getElementById("createRButton").addEventListener("click", createReimbursement);
	document.getElementById("updateRButton").addEventListener("click", updateReimbursement);
}

var URL = "http://localhost:8080/EmployeePortal/api/reimbursements";


console.log("hello");
$(document).ready( function () {
    $('#table_id').DataTable({
    	ajax: {
    		url: 'http://localhost:8080/EmployeePortal/api/reimbursements', //where to find the data
    		dataSrc:''
    	},
    	columns:[
    		{data: "rId"},
    		{data: "rAmount"},
    		{data: "rStatus"},
    		{data: "description"},
    		{data: "rStatusChange"},
    		{data: "employee_id"}
    	]
    });
    
    $('#table_id2').DataTable({
    	ajax: {
    		url: 'http://localhost:8080/EmployeePortal/api/employees', //where to find the data
    		dataSrc:''
    	},
    	columns:[
    		{data: "eId"},
    		{data: "fname"},
    		{data: "lname"},
    		{data: "email"},
    		{data: "mId"}
    	]
    });
} );

///////////////////////////////
//////REIMBURSMENT AJAX////////
////////////////////////////////


function createReimbursement() {
	
	let amount = document.getElementById("rAmount").value;
	let description = document.getElementById("rDesc").value;
	
	
	
    let reimbursement = 
         {
            rAmount: amount,
            description: description
          };

    console.log(reimbursement);
  makeAjaxPost(URL, printFlightResponse, reimbursement);
}

function printFlightResponse(xhrOBJ) {
	  console.log(xhrOBJ.response);
	}

// // Post Function // // 

function makeAjaxPost(url, callback, newFlightObject) {
  let xhr = new XMLHttpRequest();
  xhr.open("POST", url);
  xhr.onreadystatechange = function() {
    if (xhr.readystate===4&&xhr.status===201) {
      callback(this);
    }else {
      //console.log(xhr.response);
    }
  }
  xhr.setRequestHeader("Content-Type", "application/json");
  let flightCreated = JSON.stringify(newFlightObject);
  console.log(JSON.stringify(newFlightObject));
  xhr.send(flightCreated);
}

function updateReimbursement() {
	
	let identification = document.getElementById("rID").value;
	let rstatus = document.getElementById("rStatusChange").value;
	
	
	
    let reimbursement = 
         {
            rId: identification,
            rStatus: rstatus
          };

    console.log(reimbursement);
  makeAjaxPut(URL, printFlightResponse, reimbursement);
}



// // Put Function // // 

function makeAjaxPut(url, callback, newFlightObject) {
  let xhr = new XMLHttpRequest();
  xhr.open("PUT", url);
  xhr.onreadystatechange = function() {
    if (xhr.readystate===4&&xhr.status===201) {
      callback(this);
    }else {
      //console.log(xhr.response);
    }
  }
  xhr.setRequestHeader("Content-Type", "application/json");
  let flightCreated = JSON.stringify(newFlightObject);
  console.log(JSON.stringify(newFlightObject));
  xhr.send(flightCreated);
}
  

//////////////////////////////////////
//////END of REIMBURSMENT AJAX////////
/////////////////////////////////////
  
  