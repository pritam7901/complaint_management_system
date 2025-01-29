<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Grievance Process</title>
</head>
<body>
    <%
       
     	

        // Retrieve the regdno as a String from the session
        String regdNoStr = (String) session.getAttribute("regdno");
        int regdNo = 0;

        try {
            // Convert the regdNo String to an Integer
            if (regdNoStr != null && !regdNoStr.isEmpty()) {
                regdNo = Integer.parseInt(regdNoStr);
            } else {
                out.println("Student registration number is missing.");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("Invalid registration number format.");
            return;
        }

        String category = request.getParameter("category");
        String department = request.getParameter("department");
        String description = request.getParameter("description");

        // Validate input
        if (category == null || category.isEmpty() ||
            department == null || department.isEmpty() ||
            description == null || description.isEmpty()) {
            out.println("All fields are required.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

            // Prepare and execute SQL statement
            String sql = "INSERT INTO grievances (student_regno, category, department, description, status) VALUES (?, ?, ?, ?, 'Submitted')";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            stmt.setInt(1, regdNo);
            stmt.setString(2, category);
            stmt.setString(3, department);
            stmt.setString(4, description);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Retrieve the generated grievance ID
                ResultSet rs = stmt.getGeneratedKeys();
                int grievanceId = 0;
                if (rs.next()) {
                    grievanceId = rs.getInt(1); // Retrieve the first generated key
                }
                rs.close();
                
 
                // Redirect to success page with grievance ID and submission date
                session.setAttribute("grievance_id", grievanceId);
                session.setAttribute("submissionDate", new java.util.Date()); // Store current date as submission date
                response.sendRedirect("successsubmission.jsp");
            } else {
                out.println("Failed to submit grievance. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
