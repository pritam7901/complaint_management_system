<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Grievances</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background-color: #333;
            color: #fff;
        }

        .header img {
            height: 50px;
            margin-right: 15px;
        }

        .header h1 {
            margin: 0;
            font-size: 22px;
        }

        .header button {
            background-color: #007bff;
            border: none;
            color: #fff;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        .table-container {
            padding: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #333;
            color: #fff;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .action-buttons button,
        .action-buttons select {
            margin-right: 5px;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 3px;
        }

        .action-buttons .view-btn {
            background-color: #17a2b8;
            color: #fff;
        }

        .action-buttons .submit-btn {
            background-color: #007bff;
            color: #fff;
        }

        .action-buttons .delete-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .action-buttons select {
            padding: 5px;
            font-size: 14px;
        }
    </style>
</head>

<body>

    <div class="header">
        <div class="left-section">
            <img src="soalogo.png" alt="College Logo">
            <h1>Siksha 'O' Anusandhan GMS</h1>
        </div>
        <div class="right-section">
            <button onclick="window.location.href='admindashboard.jsp'">Go to Dashboard</button>
        </div>
    </div>

    <div class="table-container">
        <h2>Pending Grievances</h2>
        <table class="table">
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

                        String query = "SELECT grievance_id, student_regno, category, department, description, submission_date, status FROM grievances WHERE status = 'pending'";
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
                                
                                <option value="pending" <%= "pending".equals(status) ? "selected" : "" %>>Pending</option>
                                
                            </select>
                            
                            <button class="delete-btn" type="button" onclick="deleteGrievance(<%= grievanceId %>)">Delete</button>
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
    </div>

    <script>
        function viewDetails(id) {
            // Logic to view details
            alert("View details for grievance ID: " + id);
        }

        function submitAction(id) {
            // Logic to submit action
            alert("Submit action for grievance ID: " + id);
        }

        function deleteGrievance(id) {
            // Logic to delete grievance
            if (confirm("Are you sure you want to delete this grievance?")) {
                alert("Grievance ID " + id + " deleted.");
            }
        }
    </script>

</body>

</html>
