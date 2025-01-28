<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.DriverManager" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rejected Grievances</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="grievances.css">
</head>

<body>
    <h1>Rejected Grievances</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Registration Number</th>
                <th>Category</th>
                <th>Department</th>
                <th>Description</th>
                <th>Date Submitted</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                    String query = "SELECT grievance_id, student_regno, category, department, description, submission_date, status FROM grievances WHERE status = 'rejected'";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int grievanceId = rs.getInt("grievance_id");
                        int studentRegNo = rs.getInt("student_regno");
                        String category = rs.getString("category");
                        String department = rs.getString("department");
                        String description = rs.getString("description");
                        String submissionDate = rs.getString("submission_date");
                        String status = rs.getString("status");
            %>
            <tr>
                <td><%= grievanceId %></td>
                <td><%= studentRegNo %></td>
                <td><%= category %></td>
                <td><%= department %></td>
                <td><%= description %></td>
                <td><%= submissionDate %></td>
                <td><%= status %></td>
                <td>
                    <div class="action-buttons">
                        <select name="action_<%= grievanceId %>">
                            <option value="rejected" selected>Rejected</option>
                            
                        </select>
                        
                        <button type="button" onclick="deleteGrievance(<%= grievanceId %>)">Delete</button>
                    </div>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>

    <script>
        function viewDetails(id) {
            alert("View details for grievance ID: " + id);
        }

        function submitAction(id) {
            alert("Submit action for grievance ID: " + id);
        }

        function deleteGrievance(id) {
            if (confirm("Are you sure you want to delete this grievance?")) {
                alert("Grievance ID " + id + " deleted.");
            }
        }
    </script>
</body>

</html>
