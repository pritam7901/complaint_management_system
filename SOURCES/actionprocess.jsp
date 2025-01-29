<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grievance Action Process</title>
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
        <h2>Processing Grievance Actions</h2>
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

                    // Update grievance status
                    String newStatus = request.getParameter("status");
                    if (newStatus != null) {
                        String updateQuery = "UPDATE grievances SET status = ? WHERE grievance_id = ?";
                        stmt = conn.prepareStatement(updateQuery);
                        stmt.setString(1, newStatus);
                        stmt.setInt(2, Integer.parseInt(grievanceId));
                        int updateCount = stmt.executeUpdate();
                        if (updateCount > 0) {
                            message = "Grievance status updated successfully.";
                        } else {
                            message = "Failed to update grievance status. Please check the grievance ID.";
                        }
                    }

                    // Delete grievance
                    if (request.getParameter("delete") != null) {
                        String deleteQuery = "DELETE FROM grievances WHERE grievance_id = ?";
                        stmt = conn.prepareStatement(deleteQuery);
                        stmt.setInt(1, Integer.parseInt(grievanceId));
                        int deleteCount = stmt.executeUpdate();
                        if (deleteCount > 0) {
                            message = "Grievance deleted successfully.";
                        } else {
                            message = "Failed to delete grievance. Please check the grievance ID.";
                        }
                    }

                    // View grievance details (and print)
                    if (request.getParameter("viewDetails") != null) {
                        String detailsQuery = "SELECT * FROM grievances WHERE grievance_id = ?";
                        stmt = conn.prepareStatement(detailsQuery);
                        stmt.setInt(1, Integer.parseInt(grievanceId));
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            int studentRegNo = rs.getInt("student_regno");
                            String category = rs.getString("category");
                            String department = rs.getString("department");
                            String description = rs.getString("description");
                            String submissionDate = rs.getString("submission_date");
                            String status = rs.getString("status");
                            String grievanceResponse = rs.getString("response");

                            out.println("<h3>Grievance Details:</h3>");
                            out.println("<table class='table table-bordered'><tr><th>ID</th><td>" + grievanceId + "</td></tr>");
                            out.println("<tr><th>Registration Number</th><td>" + studentRegNo + "</td></tr>");
                            out.println("<tr><th>Category</th><td>" + category + "</td></tr>");
                            out.println("<tr><th>Department</th><td>" + department + "</td></tr>");
                            out.println("<tr><th>Description</th><td>" + description + "</td></tr>");
                            out.println("<tr><th>Date Submitted</th><td>" + submissionDate + "</td></tr>");
                            out.println("<tr><th>Status</th><td>" + status + "</td></tr>");
                            out.println("<tr><th>Response</th><td>" + (response != null ? response : "No response") + "</td></tr></table>");

                            out.println("<button onclick='window.print()' class='btn btn-info'>Print Details</button>");
                        } else {
                            out.println("<div class='alert alert-danger'>No grievance found with the given ID.</div>");
                        }
                        rs.close();
                    }

                    if (!message.isEmpty()) {
                        out.println("<div class='alert alert-success'>" + message + "</div>");
                    }

                } catch (SQLException | ClassNotFoundException e) {
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                } finally {
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>

        <!-- Form for sending response -->
        <form action="sendresponseprocess.jsp" method="post">
            <input type="hidden" name="grievance_id" value="<%= grievanceId %>">
            <h3>Send Response</h3>
            <textarea name="response" rows="5" class="form-control" placeholder="Enter response here"></textarea>
            <button type="submit" name="submitResponse" class="btn btn-success mt-3">Send Response</button>
        </form>

        <a href="allgrievances.jsp" class="btn btn-primary mt-3">Back to All Grievances</a>
    </div>
</body>

</html>
