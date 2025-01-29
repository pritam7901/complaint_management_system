<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View and Update Grievance</title>
</head>
<body>
    <h2>View and Update Grievance</h2>

    <%
        String status = request.getParameter("status");
        String jdbcURL = "jdbc:mysql://localhost:3306/cmpdb";
        String dbUser = "root";
        String dbPassword = "Password@123";

        // Display grievances based on status
        String selectQuery = "SELECT * FROM grievances WHERE status = ?";
        
        // Update grievance status
        if ("update".equals(request.getParameter("action"))) {
            int grievanceId = Integer.parseInt(request.getParameter("grievance_id"));
            String newStatus = request.getParameter("status");
            String updateQuery = "UPDATE grievances SET status = ? WHERE grievance_id = ?";
            
            try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                stmt.setString(1, newStatus);
                stmt.setInt(2, grievanceId);
                stmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Category</th>
                <th>Department</th>
                <th>Description</th>
                <th>Submission Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password");
                     PreparedStatement stmt = conn.prepareStatement(selectQuery)) {
                    stmt.setString(1, status);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        int grievanceId = rs.getInt("grievance_id");
                        String category = rs.getString("category");
                        String department = rs.getString("department");
                        String description = rs.getString("description");
                        Timestamp submissionDate = rs.getTimestamp("submission_date");
                        String currentStatus = rs.getString("status");
            %>
            <tr>
                <td><%= grievanceId %></td>
                <td><%= category %></td>
                <td><%= department %></td>
                <td><%= description %></td>
                <td><%= submissionDate %></td>
                <td><%= currentStatus %></td>
                <td>
                    <a href="viewupdategrievance.jsp?grievance_id=<%= grievanceId %>">View Details</a>
                </td>
            </tr>
            <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <a href="admindashboard.jsp">Back to Dashboard</a>
</body>
</html>
