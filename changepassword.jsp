<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 20px;
        }
        .success-message {
            color: green;
        }
        .error-message {
            color: red;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Change Password</h2>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String message = "";
            String currentPassword = "";
            String newPassword = "";
            String confirmPassword = "";

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

                    // Check if form is submitted
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        currentPassword = request.getParameter("current_password");
                        newPassword = request.getParameter("new_password");
                        confirmPassword = request.getParameter("confirm_password");

                        if (currentPassword != null && !currentPassword.trim().isEmpty() &&
                            newPassword != null && !newPassword.trim().isEmpty() &&
                            confirmPassword != null && !confirmPassword.trim().isEmpty()) {

                            if (newPassword.equals(confirmPassword)) {
                                // Check current password
                                String checkPasswordQuery = "SELECT password FROM students_details WHERE regdno = ?";
                                stmt = conn.prepareStatement(checkPasswordQuery);
                                stmt.setInt(1, regdno);
                                rs = stmt.executeQuery();

                                if (rs.next()) {
                                    String storedPassword = rs.getString("password");

                                    if (storedPassword.equals(currentPassword)) {
                                        // Update password
                                        String updatePasswordQuery = "UPDATE students_details SET password = ? WHERE regdno = ?";
                                        stmt = conn.prepareStatement(updatePasswordQuery);
                                        stmt.setString(1, newPassword);
                                        stmt.setInt(2, regdno);
                                        int rowsAffected = stmt.executeUpdate();

                                        if (rowsAffected > 0) {
                                            message = "Password updated successfully.";
                                        } else {
                                            message = "Failed to update password.";
                                        }
                                    } else {
                                        message = "Current password is incorrect.";
                                    }
                                } else {
                                    message = "Error retrieving current password.";
                                }
                            } else {
                                message = "New password and confirm password do not match.";
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

        <form action="changepassword.jsp" method="post">
            <div class="form-group">
                <label for="current_password">Current Password</label>
                <input type="password" class="form-control" id="current_password" name="current_password" required>
            </div>
            <div class="form-group">
                <label for="new_password">New Password</label>
                <input type="password" class="form-control" id="new_password" name="new_password" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm New Password</label>
                <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
            </div>
            <button type="submit" class="btn btn-primary">Change Password</button>
        </form>

        <% if (!message.isEmpty()) { %>
            <div class="alert <%= message.contains("successfully") ? "alert-success success-message" : "alert-danger error-message" %> mt-3">
                <%= message %>
            </div>
        <% } %>

        <a href="userdashboard.jsp" class="btn btn-primary mt-3">Go to Dashboard</a>
    </div>
</body>

</html>
