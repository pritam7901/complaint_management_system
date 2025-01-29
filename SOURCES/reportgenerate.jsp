 <%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Report</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h2>Grievance Report</h2>
    <form method="post" action="reportgenerate.jsp">
        <input type="submit" name="generateReport" value="Generate Report for Last Month">
    </form>

    <!-- Download CSV Button -->
    <form method="post" action="reportgenerate.jsp">
        <input type="hidden" name="downloadCsv" value="true">
        <input type="submit" value="Download CSV">
    </form>

    <%
        if (request.getParameter("generateReport") != null) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                // SQL query to get grievances from the last month
                String sql = "SELECT * FROM grievances WHERE submission_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                // Display the report in a table
                out.println("<table>");
                out.println("<tr><th>Grievance ID</th><th>Student Reg No</th><th>Category</th><th>Department</th><th>Description</th><th>Submission Date</th><th>Status</th><th>Response</th><th>Response Date</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("grievance_id") + "</td>");
                    out.println("<td>" + rs.getInt("student_regno") + "</td>");
                    out.println("<td>" + rs.getString("category") + "</td>");
                    out.println("<td>" + rs.getString("department") + "</td>");
                    out.println("<td>" + (rs.getString("description") != null ? rs.getString("description") : "") + "</td>");
                    out.println("<td>" + (rs.getTimestamp("submission_date") != null ? rs.getTimestamp("submission_date") : "") + "</td>");
                    out.println("<td>" + (rs.getString("status") != null ? rs.getString("status") : "") + "</td>");
                    out.println("<td>" + (rs.getString("response") != null ? rs.getString("response") : "") + "</td>");
                    out.println("<td>" + (rs.getDate("response_date") != null ? rs.getDate("response_date") : "") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error generating report: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        }

        // Handling CSV Download
        if ("true".equals(request.getParameter("downloadCsv"))) {
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=grievance_report.csv");

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");

                // SQL query to get grievances from the last month
                String sql = "SELECT * FROM grievances WHERE submission_date >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                // Write CSV header
                out.println("Grievance ID,Student Reg No,Category,Department,Description,Submission Date,Status,Response,Response Date");

                // Write CSV data
                while (rs.next()) {
                    out.print((rs.getInt("grievance_id") != 0 ? rs.getInt("grievance_id") : "") + ",");
                    out.print((rs.getInt("student_regno") != 0 ? rs.getInt("student_regno") : "") + ",");
                    out.print((rs.getString("category") != null ? rs.getString("category") : "") + ",");
                    out.print((rs.getString("department") != null ? rs.getString("department") : "") + ",");
                    out.print((rs.getString("description") != null ? rs.getString("description").replaceAll(",", " ") : "") + ",");
                    out.print((rs.getTimestamp("submission_date") != null ? rs.getTimestamp("submission_date") : "") + ",");
                    out.print((rs.getString("status") != null ? rs.getString("status") : "") + ",");
                    out.print((rs.getString("response") != null ? rs.getString("response").replaceAll(",", " ") : "") + ",");
                    out.println((rs.getDate("response_date") != null ? rs.getDate("response_date") : ""));
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error generating CSV: " + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
            out.flush();
            out.close();
        }
    %>
</body>
</html>
 