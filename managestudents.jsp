<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
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

        .action-buttons button {
            margin-right: 5px;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 3px;
        }

        .view-btn {
            background-color: #17a2b8;
            color: #fff;
        }

        .edit-btn {
            background-color: #ffc107;
            color: #fff;
        }

        .delete-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .notify-btn {
            background-color: #28a745;
            color: #fff;
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
        <h2>Manage Students</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>Reg. No.</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        // Load JDBC driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish connection
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                        // Query to fetch student details
                        String query = "SELECT * FROM students_details";
                        stmt = conn.prepareStatement(query);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int regNo = rs.getInt("regdno");
                            String name = rs.getString("full_name");
                            String department = rs.getString("branch");
                            String email = rs.getString("email");
                %>
                            <tr>
                                <td><%= regNo %></td>
                                <td><%= name %></td>
                                <td><%= department %></td>
                                <td><%= email %></td>
                                <td class="action-buttons">
                                    <button class="view-btn" onclick="window.location.href='viewStudentDetails.jsp?regno=<%= regNo %>'">View Details</button>
                                    <button class="edit-btn" onclick="window.location.href='editStudent.jsp?regno=<%= regNo %>'">Edit Info</button>
                                    <button class="delete-btn" onclick="if(confirm('Are you sure you want to delete this student?')) window.location.href='deleteStudent.jsp?regno=<%= regNo %>'">Delete</button>
                                    <button class="notify-btn" onclick="window.location.href='sendNotification.jsp?regno=<%= regNo %>'">Send Notification</button>
                                </td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>

</body>

</html>
