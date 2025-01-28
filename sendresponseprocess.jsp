<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Response</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 20px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Send Response</h2>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            String message = "";
            String grievanceId = request.getParameter("grievance_id");
            
            if (grievanceId == null || grievanceId.isEmpty()) {
                out.println("<div class='alert alert-danger'>Error: Grievance ID is missing.</div>");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                    // Save response
                    String responseText = request.getParameter("response");
                    if (responseText != null && !responseText.isEmpty()) {
                        String responseUpdateQuery = "UPDATE grievances SET response = ?, response_date = NOW() WHERE grievance_id = ?";
                        stmt = conn.prepareStatement(responseUpdateQuery);
                        stmt.setString(1, responseText);
                        stmt.setInt(2, Integer.parseInt(grievanceId));
                        int updateCount = stmt.executeUpdate();
                        if (updateCount > 0) {
                            message = "Response sent successfully.";
                        } else {
                            message = "Failed to send response. Please check the grievance ID.";
                        }
                    } else {
                        message = "Response cannot be empty.";
                    }

                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                    e.printStackTrace();
                } finally {
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>
        <div class="alert alert-success"><%= message %></div>
        <a href="allgrievances.jsp" class="btn btn-primary mt-3">Back to All Grievances</a>
    </div>
</body>

</html>
