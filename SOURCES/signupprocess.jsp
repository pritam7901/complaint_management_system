 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.IOException"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Signup Process</title>
    <style>
    .loader {
         border: 16px solid #f3f3f3;
        border-radius: 50%;
        border-top: 16px solid #3498db;
        width: 80px;
        height: 80px;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .loading-text {
          margin-top: 20px;
        font-size: 18px;
        color: #3498db;
        text-align: center;
    }

    .loader-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(255, 255, 255, 0.8);
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
</style>
    
    
</head>
<body>
   <div class="loader-container">
    <div class="loader"></div>
    <div class="loading-text">Loading, please wait...</div>
</div>
   
    <%
        String regdnoStr = request.getParameter("regdno");
        String full_name = request.getParameter("full_name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String branch = request.getParameter("branch");
        String college = request.getParameter("college");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");

        if (password == null || confirm_password == null || !password.equals(confirm_password)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        int regdno;
        try {
            regdno = Integer.parseInt(regdnoStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid registration number.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (phone.length() != 10) {
            request.setAttribute("errorMessage", "Phone number must be exactly 10 digits.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

            // Check if registration number already exists
            String checkQuery = "SELECT COUNT(*) FROM students_details WHERE regdno = ?";
            ps = con.prepareStatement(checkQuery);
            ps.setInt(1, regdno);
            rs = ps.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                request.setAttribute("errorMessage", "Registration number already exists.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Check if email already exists
            checkQuery = "SELECT COUNT(*) FROM students_details WHERE email = ?";
            ps = con.prepareStatement(checkQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                request.setAttribute("errorMessage", "Email already exists.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Check if phone number already exists
            checkQuery = "SELECT COUNT(*) FROM students_details WHERE phone = ?";
            ps = con.prepareStatement(checkQuery);
            ps.setString(1, phone);
            rs = ps.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                request.setAttribute("errorMessage", "Phone number already exists.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Insert new user (excluding confirm_password)
            String insertQuery = "INSERT INTO students_details (regdno, full_name, phone, email, branch, college, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(insertQuery);
            ps.setInt(1, regdno);
            ps.setString(2, full_name);
            ps.setString(3, phone);
            ps.setString(4, email);
            ps.setString(5, branch);
            ps.setString(6, college);
            ps.setString(7, password);
            int k = ps.executeUpdate();

            if (k > 0) {
            	session.setAttribute("fullname", full_name);
                request.setAttribute("successMessage", "Your registration is successful.");
                response.setHeader("Refresh", "2; URL=userlogin.jsp");
            } else {
                request.setAttribute("errorMessage", "An error occurred. Please try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
 