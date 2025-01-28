<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logging Out...</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            text-align: center;
            margin-top: 50px;
        }
        .spinner-border {
            width: 3rem;
            height: 3rem;
            border-width: 0.5rem;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">Loading...</span>
        </div>
        <h2 class="mt-3">Logout successful. You should be redirected shortly.</h2>
    </div>

    <script>
        // Redirect to home page after 3 seconds
        setTimeout(function() {
            window.location.href = 'main.jsp'; // Change 'home.jsp' to your actual home page URL
        }, 2000);
    </script>
</body>

</html>
