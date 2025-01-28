  <%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Grievance Status</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Link to your CSS file -->
    <style>
        /* Zebra Stripe Table Styling */
        table {
            width: 80%;
            height:60vh;
            border-collapse: collapse;
            margin: 15px 0;
            font-size: 1em;
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            position:center;
            
        }

        table, th, td {
            border: 1px solid #ddd;
            text-align: left;
        }

        th, td {
            padding: 12px;
        }

        th {
            
            color:black;
            font-weight: bold;
        }
 

        /* Zebra striping for table rows */
        tr:nth-child(even) td {
            background-color: #e9ecef;
        }
        tr:nth-child(even) th {
            background-color: #e9ecef;
        }

        /* Layout for links and buttons */
        .navigation {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        #backLink {
            color: #0056b3;
            text-decoration: none;
            font-weight: bold;
            font-size:20px;
        }

        #backLink:hover {
            text-decoration: underline;
        }

        #printButton {
            background-color: #0056b3;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
            position:center;
            margin-right:300px;
        }

        #printButton:hover {
            background-color: #004494;
        }
    </style>
    <script>
        function printPage() {
            window.print();
        }
    </script>
</head>
<body>
    <h1>Grievance Status Details</h1>
    
    <%
        int grievanceId = Integer.parseInt(request.getParameter("grievanceId"));
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String dbURL = "jdbc:mysql://localhost:3306/cmpdb";
        String dbUser = "root";
        String dbPass = "Password@123";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, dbUser, dbPass);
            String query = "SELECT * FROM grievances WHERE grievance_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, grievanceId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                int studentRegno = rs.getInt("student_regno");
                String description = rs.getString("description");
                String category = rs.getString("category");
                String department = rs.getString("department");
                String status = rs.getString("status");
                String submissionDate = rs.getString("submission_date");
                String resolutionDate = rs.getString("response_date");
                String responses = rs.getString("response");
    %>
                <table>
                    <tr>
                        <th>Student Registration Number</th>
                        <td><%= studentRegno %></td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td><%= description %></td>
                    </tr>
                    <tr>
                        <th>Category</th>
                        <td><%= category %></td>
                    </tr>
                    <tr>
                        <th>Department</th>
                        <td><%= department %></td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td><%= status %></td>
                    </tr>
                    <tr>
                        <th>Submission Date</th>
                        <td><%= submissionDate %></td>
                    </tr>
                    <tr>
                        <th>Resolution Date</th>
                        <td><%= resolutionDate != null ? resolutionDate : "Not Resolved Yet" %></td>
                    </tr>
                    <tr>
                        <th>Responses</th>
                        <td><%= responses != null ? responses : "No Responses Yet" %></td>
                    </tr>
                </table>
    <%
            } else {
    %>
                <p>No grievance found with ID: <%= grievanceId %></p>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
                <p>Error occurred while fetching the grievance details.</p>
    <%
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    <div class="navigation">
        <a id="backLink" href="userdashboard.jsp">Back to Dashboard</a> <!-- Link back to user dashboard -->
        <button id="printButton" onclick="printPage()">Print</button> <!-- Print Button -->
    </div>
</body>
</html>
 