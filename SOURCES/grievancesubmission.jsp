 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>

<%
    // Check if session is null or the regdno attribute is not set
    Object regdNoObj = session.getAttribute("regdno");
    int regdno = 0;
    if (regdNoObj != null) {
        if (regdNoObj instanceof Integer) {
            regdno = (Integer) regdNoObj;
        } else if (regdNoObj instanceof String) {
            try {
                regdno = Integer.parseInt((String) regdNoObj);
            } catch (NumberFormatException e) {
                // Handle the exception if needed
                e.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Grievance</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        body {
            padding-top: 0px; 
             background-color:#e9ecef; /* Light gray background */
            backdrop-filter: blur(1px); 
        }

        .navbar-brand {
            font-size: 1.5rem;
        }

        .container {
            max-width: 900px;
            height: 45vh;
        }

        form .form-row {
            margin-bottom: 1rem;
        }

        .form-control {
            margin-bottom: 1rem;
        }

        .form-row.align-items-center {
            flex-direction: column;
        }

        @media (max-width: 767.98px) {
            .navbar-collapse {
                text-align: center;
            }

            .navbar-toggler {
                border: none;
            }

            .form-row .form-control {
                margin-bottom: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="navbar-brand" href="#">Siksha 'O' Anusandhan</div>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <button><a class="nav-link" href="userdashboard.jsp">Go to Dashboard</a></button>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Grievance Form -->
    <div class="container mt-5">
        <h2>Submit Grievance</h2>
        <form action="GrievanceSubmitProcess.jsp" method="post">
            <div class="form-row">
                <div class="col-md-12">
                    <label for="regno">Registration No.</label>
                    <input type="text" class="form-control" id="regno" name="regno" value="<%= regdno %>" readonly>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <label for="category">Category</label>
                    <select class="form-control" id="category" name="category" required>
                        <option value="">Select Category</option>
                        <option value="Canteen">Canteen</option>
                        <option value="Transportation">Transportation</option>
                        <option value="Sports">Sports</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <label for="department">Department</label>
                    <select class="form-control" id="department" name="department" required>
                        <option value="">Select Department</option>
                        <option value="Canteen">Canteen</option>
                        <option value="Transport">Transport</option>
                        <option value="Sports">Sports</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-12">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                    <small class="form-text text-muted">Description should not exceed 1000 words.</small>
                </div>
            </div>
            <div class="form-row mt-3">
                <div class="col-md-6">
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='userdashboard.jsp'">Back</button>
                </div>
                <div class="col-md-6 text-right">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
 