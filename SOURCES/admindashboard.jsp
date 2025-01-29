<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.DriverManager" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="admindashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    
</head>

<body>
    <!-- New College Header -->
    <div class="college-header">
        <img src="soalogo.png" alt="College Logo"> <!-- Changed image format to JPG -->
        <h1><b>SOA GMS</b></h1>
    </div>
    <div class="sidebar">
        <div class="admin-header">
            <i class="fas fa-user-shield"></i> Admin
        </div>
        <ul>
            <li><a href="admineditprofile.jsp"><i class="fas fa-user"></i> Profile</a></li>
            <li><a href="#"><i class="fas fa-envelope"></i> Message</a></li>
            <li><a href="#"><i class="fas fa-cogs"></i> General</a></li>
            <li><a href="managestudents.jsp"><i class="fas fa-users"></i> Users</a></li>
            <li><a href="#"><i class="fas fa-plus"></i> Add Members</a></li>
            
        </ul>
    </div>
    <div class="main-content">
        <div class="header-box">
            <div class="header">
                <div class="center">
                    <h2>Welcome, Admin</h2>
                </div>
                <div class="header-buttons">
                    <button><a href="adminlogout.jsp">Logout</a></button>
                    <button>Info</button>
                    <span class="date">Thursday, Aug 8, 2024</span>
                </div>
            </div>
        </div>
        <div class="dashboard">
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet resultSet = null;
                try {
                    // Load JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                    // Query to get counts
                    String query = "SELECT COUNT(*) FROM grievances";
                    stmt = conn.prepareStatement(query);
                    resultSet = stmt.executeQuery();
                    int allGrievancesCount = 0;
                    if (resultSet.next()) {
                        allGrievancesCount = resultSet.getInt(1);
                    }

                    query = "SELECT COUNT(*) FROM grievances WHERE status = 'pending'";
                    stmt = conn.prepareStatement(query);
                    resultSet = stmt.executeQuery();
                    int pendingGrievancesCount = 0;
                    if (resultSet.next()) {
                        pendingGrievancesCount = resultSet.getInt(1);
                    }

                    query = "SELECT COUNT(*) FROM grievances WHERE status = 'solved'";
                    stmt = conn.prepareStatement(query);
                    resultSet = stmt.executeQuery();
                    int solvedGrievancesCount = 0;
                    if (resultSet.next()) {
                        solvedGrievancesCount = resultSet.getInt(1);
                    }

                    query = "SELECT COUNT(*) FROM grievances WHERE status = 'rejected'";
                    stmt = conn.prepareStatement(query);
                    resultSet = stmt.executeQuery();
                    int rejectedGrievancesCount = 0;
                    if (resultSet.next()) {
                        rejectedGrievancesCount = resultSet.getInt(1);
                    }

                    query = "SELECT COUNT(*) FROM students_details";
                    stmt = conn.prepareStatement(query);
                    resultSet = stmt.executeQuery();
                    int usersCount = 0;
                    if (resultSet.next()) {
                        usersCount = resultSet.getInt(1);
                    }
            %>

            <div class="box blue"><b><a href="allgrievances.jsp">All Grievances (<%= allGrievancesCount %>)</a></b></div>
            <div class="box orange"><b><a href="pendinggrievances.jsp">Pending Grievances (<%= pendingGrievancesCount %>)</a></b></div>
            <div class="box red"><b><a href="solvedgrievances.jsp">Solved Grievances (<%= solvedGrievancesCount %>)</a></b></div>
            <div class="box teal"><b><a href="managestudents.jsp">Manage Students (<%= usersCount %>)</a></b></div>
            <div class="box green"><b><a href="viewdetailsgrievances.jsp">Forward Complaints</a></b></div>
            <div class="box light-gray"><b><a href="rejectedgrievances.jsp">Rejected grievance (<%= rejectedGrievancesCount %>)</a></b></div>
            
            

            <%
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace(); // Handle exceptions
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
        <button class="small-button">View Feedback</button>
        <a href="reportgenerate.jsp">
    <button class="small-button">Generate Reports</button>
</a>
        
    </div>
</body>

</html>
