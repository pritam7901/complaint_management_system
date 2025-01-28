<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 20px;
        }
        .success-message {
            color: green;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>User Profile</h2>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String message = "";
            String fullName = "";
            String email = "";
            String phone = "";

            // Get the logged-in student's registration number from session
            Object regdNoObj = session.getAttribute("regdno");
            int regdno = 0;
            if (regdNoObj != null) {
                if (regdNoObj instanceof Integer) {
                    regdno = (Integer) regdNoObj;
                } else if (regdNoObj instanceof String) {
                    try {
                        regdno = Integer.parseInt((String) regdNoObj);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            }

            if (regdno == 0) {
                out.println("<div class='alert alert-danger'>Error: Registration number not found.</div>");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                    // Fetch user details
                    String query = "SELECT full_name, email, phone FROM students_details WHERE regdno = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, regdno);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        fullName = rs.getString("full_name");
                        email = rs.getString("email");
                        phone = rs.getString("phone");
                    }

                    // Check if form is submitted
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String updatedName = request.getParameter("full_name");
                        String updatedEmail = request.getParameter("email");
                        String updatedPhone = request.getParameter("phone");
                        if (updatedName != null && !updatedName.trim().isEmpty() &&
                            updatedEmail != null && !updatedEmail.trim().isEmpty() &&
                            updatedPhone != null && !updatedPhone.trim().isEmpty()) {
                            // Update user details
                            String updateQuery = "UPDATE students_details SET full_name = ?, email = ?, phone = ? WHERE regdno = ?";
                            stmt = conn.prepareStatement(updateQuery);
                            stmt.setString(1, updatedName);
                            stmt.setString(2, updatedEmail);
                            stmt.setString(3, updatedPhone);
                            stmt.setInt(4, regdno);
                            int rowsAffected = stmt.executeUpdate();
                            
                            if (rowsAffected > 0) {
                                message = "Profile updated successfully.";
                                fullName = updatedName; // Update the displayed name
                                email = updatedEmail;
                                phone = updatedPhone;
                            } else {
                                message = "Failed to update profile.";
                            }
                        } else {
                            message = "All fields are required.";
                        }
                    }

                } catch (SQLException | ClassNotFoundException e) {
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>
        
        <form action="usereditprofile.jsp" method="post">
            <div class="form-group">
                <label for="full_name">Full Name</label>
                <input type="text" class="form-control" id="full_name" name="full_name" value="<%= fullName %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= phone %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>

        <% if (!message.isEmpty()) { %>
            <div class="alert <%= message.contains("successfully") ? "alert-success success-message" : "alert-danger" %> mt-3">
                <%= message %>
            </div>
        <% } %>

        <a href="userdashboard.jsp" class="btn btn-primary mt-3">Go to Dashboard</a>
    </div>
</body>

</html>
