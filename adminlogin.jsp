<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management System - Admin Login</title>
    <style>
        body {
            margin: 0;
            height: 110vh;
            overflow: hidden;
            display: flex;
            flex-direction: column; /* Changed to column to accommodate the header */
            background: url("iter.jpg") no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(5px); /* Add a blur filter */
            
        }

        /* Header styles */
        .header {
            width: 100%;
            padding: 8px;
            display: flex;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.30); /* Semi-transparent background */
            color: white;
            box-sizing: border-box;
        }
        .header img {
            width: 50px;
            height: auto;
            margin-right: 15px;
        }
        .header .college-info {
            display: flex;
            flex-direction: column;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }
        .header h2 {
            margin: 5px 0 0;
            font-size: 16px;
            font-weight: normal;
        }
        .back-to-home {
            background: #007BFF;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background 0.3s;
        }
        .back-to-home:hover {
            background: #0056b3;
            }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: calc(100% - 80px); /* Adjusted height to account for the header */
            background: rgba(0, 0, 0, 0.2);
        }

        .login-card {
            width: 250px;
            padding: 20px;
            background: transparent;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
            transform-style: preserve-3d;
            transition: transform 0.5s;
            transform: rotateY(0deg);
            text-align: center;
        }

        .login-card:hover {
            transform: rotateY(5deg);
        }

        .login-card h2 {
            margin: 0 0 20px;
            font-size: 24px;
            color: #000;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card img {
            width: 30px;
            height: auto;
            margin-right: 10px;
        }

        .login-card input {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background: #f5f5f5;
            color: #000;
        }

        .login-card input::placeholder {
            color: #777;
        }

        .login-card button {
            width: 90%;
            padding: 10px;
            background: #007BFF;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }

        .login-card button:hover {
            background: green;
        }

        .forgot-password {
            display: block;
            text-align: center;
            margin-top: 10px;
        }

        .forgot-password a {
            color: black;
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }
        .error {
            color: #ff4d4d;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <div class="header">
        <img src="soalogo.png" alt="College Logo">
        <div class="college-info">
            <h1><b>SOA GMS</b></h1>
            
        </div>
         
    </div>

    <!-- Login Section -->
    <div class="login-container">
        <div class="login-card">
            <h2><img src="soalogo.png" alt="Logo"> Admin Login</h2>
            <form action="adminloginprocess.jsp" method="post">
                <input type="text" name="username" placeholder="Username" required><br>
                <input type="password" name="password" placeholder="Password" required><br>
                <%
                String error = request.getParameter("error");
                if (error != null && error.equals("true")) {
                    out.println("<div class='error'>Invalid username or password</div>");
                }
            %>
             <button type="submit">Login</button>
            </form>
            <div class="forgot-password">
                <a href="forgot-password.jsp"><b>Forgot Password?</b></a>
            </div>
             
        </div>
    </div>
</body>
</html>
