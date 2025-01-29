<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="userdashboard.css">
</head>
<body>
   <%

   Object regdNoObj = session.getAttribute("regdno");
   String regdNoStr = regdNoObj != null ? regdNoObj.toString() : "0";
   int regdNo = 0;
   if (regdNoStr != null) {
       try {
           regdNo = Integer.parseInt(regdNoStr);
       } catch (NumberFormatException e) {
           e.printStackTrace(); // Log the error or handle it accordingly
           // You might want to set a default value or show an error message
       }
   } else {
       // Handle the case where regdNoStr is null, e.g., redirect to login
       response.sendRedirect("userlogin.jsp");
   }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String fullname = "";
    int totalGrievances = 0;
    int solvedGrievances = 0;
    int pendingGrievances = 0;
    int submittedGrievances = 0;
    int rejectedGrievances = 0;  // Added for rejected grievances
    List<String> grievances = new ArrayList<>();
    List<String> notifications = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

        // Get fullname
        stmt = conn.prepareStatement("SELECT full_name FROM students_details WHERE regdno = ?");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        if (rs.next()) {
            fullname = rs.getString("full_name");
        }

        
        // Get total grievances
        stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM grievances WHERE student_regno = ?");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalGrievances = rs.getInt("total");
        }

        // Get solved grievances
        stmt = conn.prepareStatement("SELECT COUNT(*) AS solved FROM grievances WHERE student_regno = ? AND status = 'Solved'");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        if (rs.next()) {
            solvedGrievances = rs.getInt("solved");
        }

        // Get pending grievances
        stmt = conn.prepareStatement("SELECT COUNT(*) AS pending FROM grievances WHERE student_regno = ? AND status = 'Pending'");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        if (rs.next()) {
            pendingGrievances = rs.getInt("pending");
        }

        // Get submitted grievances
        stmt = conn.prepareStatement("SELECT COUNT(*) AS submitted FROM grievances WHERE student_regno = ? AND status = 'Submitted'");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        if (rs.next()) {
            submittedGrievances = rs.getInt("submitted");
        }

        // Get rejected grievances
        stmt = conn.prepareStatement("SELECT COUNT(*) AS rejected FROM grievances WHERE student_regno = ? AND status = 'Rejected'");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        if (rs.next()) {
            rejectedGrievances = rs.getInt("rejected");
        }

        // Get grievances list
        stmt = conn.prepareStatement("SELECT category, description, status, submission_date FROM grievances WHERE student_regno = ?");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        while (rs.next()) {
            String grievance = rs.getString("category") + ": " + rs.getString("description") + " (" + rs.getString("status") + ") - " + rs.getTimestamp("submission_date");
            grievances.add(grievance);
        }

     // Fetch grievance responses
        stmt = conn.prepareStatement("SELECT grievance_id, response, response_date FROM grievances WHERE student_regno = ? AND response IS NOT NULL ORDER BY response_date DESC");
        stmt.setInt(1, regdNo);
        rs = stmt.executeQuery();
        while (rs.next()) {
            String grievanceId = rs.getString("grievance_id");
            String grievanceResponse = rs.getString("response");
            String responseDate = rs.getTimestamp("response_date").toString();
            String fullResponse = "Grievance ID: " + grievanceId   + "  Response: " + grievanceResponse   + " - Date: " + responseDate;
            grievances.add(fullResponse);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
   
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="navbar-brand span" >
            <img src="soalogo.png" alt="College Logo" style="width: 50px; height: auto;">
            <span>Siksha 'O' Anusandhan GMS</span>
       </div>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <h1 class="navbar-text"><b>Welcome, <%= fullname %></b></h1>
        </div>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="usereditprofile.jsp"><i class="fas fa-user"></i> Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="userlogoutprocess.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Sidebar and Main Content -->
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                <div class="sidebar-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">
                                <i class="fas fa-home"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="grievancesubmission.jsp">
                                <i class="fas fa-file-alt"></i>
                                Submit Grievance
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="usertrackstatus.jsp">
                                <i class="fas fa-list"></i>
                                View Grievances
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="usereditprofile.jsp">
                                <i class="fas fa-user-cog"></i>
                                Profile Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="changepassword.jsp">
                                <i class="fas fa-edit"></i>
                                change password
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content Area -->
            <main role="main" class="col-md-9 col-lg-10 ml-sm-auto px-md-4">
                <!-- Search Filter -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h2>Grievance Summary</h2>
                    <form class="form-inline">
                        <select class="form-control" id="category">
                            <option>Category</option>
                            <option>Canteen</option>
                            <option>Transportation</option>
                            <option>Sports</option>
                        </select>
                        <input type="date" class="form-control" id="date">
                        <select class="form-control" id="status">
                            <option>Status</option>
                            <option>Submitted</option>
                            <option>Solved</option>
                            <option>Pending</option>
                            <option>Rejected</option>
                        </select>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-filter" aria-hidden="true"></i></button>
                        <button type="submit" class="btn btn-secondary ml-2"><i class="fas fa-search"></i></button>
                    </form>
                </div>

                <!-- Grievance Cards -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Total Grievances</h5>
                                <p class="card-text" id="total-grievances"><%= totalGrievances %></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Solved Grievances</h5>
                                <p class="card-text" id="solved-grievances"><%= solvedGrievances %></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Pending Grievances</h5>
                                <p class="card-text" id="pending-grievances"><%= pendingGrievances %></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-danger mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Rejected Grievances</h5>
                                <p class="card-text" id="rejected-grievances"><%= rejectedGrievances %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Grievances List -->
                <h3>My Grievances</h3>
<div class="table-responsive">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Category</th>
                <th>Description</th>
                <th>Status</th>
                <th>Submission Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (String grievance : grievances) {
                    String[] parts = grievance.split(": | \\(|\\) - ");
                    out.println("<tr><td data-label='Category'>" + parts[0] + "</td><td data-label='Description'>" + parts[1] + "</td><td data-label='Status'>" + parts[2] + "</td><td data-label='Submission Date'>" + parts[3] + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</div>
                
               <h3>My Grievance Responses</h3>
<ul class="list-group mb-4">
    <%
        for (String fullResponse : grievances) {
            // Display only grievance response details
            if (fullResponse.contains("Grievance ID:")) {
                out.println("<li class='list-group-item'>" +     fullResponse +     "</li>");
            }
        }
    %>
</ul>

                <!-- Feedback Button -->
                
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>© 2024 Siksha 'O' Anusandhan. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
