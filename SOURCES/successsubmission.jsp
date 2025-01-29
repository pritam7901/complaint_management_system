<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>

<%
Object grievanceIdStr = session.getAttribute("GrievanceId");
int grievanceId = 0;
if (grievanceIdStr != null) {
    if (grievanceIdStr instanceof Integer) {
    	grievanceId = (Integer) grievanceIdStr;
    } else if (grievanceIdStr instanceof String) {
        try {
        	grievanceId = Integer.parseInt((String) grievanceIdStr);
        } catch (NumberFormatException e) {
            // Handle the exception if needed
            e.printStackTrace();
        }
    }
}


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grievance Submission Successful</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-body">
                <div class="display-1 text-success">✓</div>
                <h2>Your grievance is successfully submitted</h2>
                 <p><strong>Grievance ID:</strong> <%=grievanceId%></p>
                
                 

                <div class="mt-3">
                    <button class="btn btn-primary" onclick="window.location.href='userdashboard.jsp'">Go to Dashboard</button>
                    <button class="btn btn-secondary" onclick="window.location.href='grievancesubmission.jsp'">Done</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
