<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>


<%
    // Get the registration number from the session
    Object regdNoObj = session.getAttribute("regdno");
    int regdno = 0;
    if (regdNoObj != null) {
        if (regdNoObj instanceof Integer) {
            regdno = (Integer) regdNoObj;
        } else if (regdNoObj instanceof String) {
            try {
                regdno = Integer.parseInt((String) regdNoObj);
            } catch (NumberFormatException e) {
                // Handle the exception if needed
                e.printStackTrace();
            }
        }
    }

    // Get the form data
    String category = request.getParameter("category");
    String department = request.getParameter("department");
    String description = request.getParameter("description");

    // Create a connection to the database
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");
    } catch (Exception e) {
        out.println("Error connecting to database: " + e.getMessage());
        return;
    }

    // Get the current date
    Date currentDate = new Date();
    java.sql.Date sqlDate = new java.sql.Date(currentDate.getTime());
    
    String formattedDate = "N/A";
    Timestamp submissionTimestamp = new Timestamp(sqlDate.getTime());

    // Get the next grievance ID
    int grievanceId = 0;
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT MAX(grievance_id) FROM grievances");
    if (rs.next()) {
        grievanceId = rs.getInt(1) + 1;
    }

    // Insert the grievance data into the database
    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO grievances (grievance_id, student_regno, category, department, description, submission_date) VALUES (?, ?, ?, ?, ?, ?)");
    pstmt.setInt(1, grievanceId);
    pstmt.setInt(2, regdno);
    pstmt.setString(3, category);
    pstmt.setString(4, department);
    pstmt.setString(5, description);
    pstmt.setTimestamp(6, submissionTimestamp);
    pstmt.executeUpdate();

    // Close the database connection
    conn.close();
	session.setAttribute("GrievanceId",grievanceId);
	session.setAttribute("SubmissionDate",submissionTimestamp);
    // Redirect to the success page
    response.sendRedirect("successsubmission.jsp");
%>
