<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Grievances</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            width: 100%;
            max-width: 100%;
        }
        .table {
            width: 100%;
            table-layout: 40px; /* Use fixed layout to ensure proper column width */
        }
        .table th, .table td {
            white-space: nowrap; /* Prevent text from wrapping */
        }
        .table td form {
            display: inline-block; /* Ensure forms are inline but block-level for proper spacing */
            margin-right: 5px; /* Space between buttons */
        }
        .table td .btn {
            margin-right: 5px; /* Space between buttons */
        }
        .btn-green {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-green:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
    </style>
</head>

<body>
    <div class="container mt-5">
        <h2 class="mb-4">All Grievances</h2>
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Registration Number</th>
                    <th>Category</th>
                    <th>Department</th>
                    <th>Description</th>
                    <th>Submission Date</th>
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
                        String query = "SELECT * FROM grievances";
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
                        <form action="actionprocess.jsp" method="post" style="display:inline-block;">
                            <input type="hidden" name="grievance_id" value="<%= grievanceId %>">
                            <select name="status" class="form-control mb-2">
                                <option value="Pending" <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                                <option value="Solved" <%= status.equals("Solved") ? "selected" : "" %>>Solved</option>
                                <option value="Rejected" <%= status.equals("Rejected") ? "selected" : "" %>>Rejected</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm">update</button>
                        </form>
                        <form action="actionprocess.jsp" method="post" style="display:inline-block;">
                            <input type="hidden" name="grievance_id" value="<%= grievanceId %>">
                            <button type="submit" name="viewDetails" class="btn btn-info btn-sm">View Details</button>
                        </form>
                        <form action="actionprocess.jsp" method="post" style="display:inline-block;">
                            <input type="hidden" name="grievance_id" value="<%= grievanceId %>">
                            <button type="submit" name="delete" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                        <form action="actionprocess.jsp" method="post" style="display:inline-block;">
                            <input type="hidden" name="grievance_id" value="<%= grievanceId %>">
                            <button type="submit" name="sendResponse" class="btn btn-green btn-sm"> Response</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>

</html>
