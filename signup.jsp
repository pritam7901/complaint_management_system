<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
             background-size: cover;
              
            
        }

        .container {
            display: flex;
            max-width:730px;
            width: 100%;
            background: rgba(255, 255, 255, 0.85);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            padding: 30px;
             background-color: #d5f4e6;
              backdrop-filter: blur(-10px);
        }

        h3 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
            text-align: center;
            width: 100%;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 15px;
        }

        .btn-primary {
            background-color: blue;
            border: none;
            font-weight: bold;
            border-radius: 10px;
            text-align:left;
             float: left;
        }

        .btn-primary:hover {
            background-color: green;
        }

        .back-button {
            position: fixed;
            top: 20px;
            left: 20px;
            font-size: 24px;
            color: blue;
            text-decoration: none;
            background: rgba(0, 0, 0, 0.0);
            padding: 10px;
            border-radius: 5px;
            z-index: 1000;
        }

        .back-button:hover {
            background: rgba(0, 0, 0, 0.1);
        }

        a {
            color: #e91e63;
        }

        a:hover {
            text-decoration: underline;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 70%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
        }

        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }

        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .form-group {
            flex: 1;
            margin-right: 15px;
            position: relative;
        }

        .form-group:last-child {
            margin-right: 0;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                max-width: 90%;
                padding: 20px;
            }

            h3 {
                font-size: 20px;
            }

            .row {
                flex-direction: column;
            }

            .form-group {
                margin-right: 0;
                margin-bottom: 15px;
            }

            .back-button {
                font-size: 20px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <a href="main.jsp" class="back-button">Home</a>
    <div class="container">
        <div class="right-section">
            <h3><b>Sign Up</b></h3>
            <form id="signupForm" action="signupprocess.jsp" method="post">
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    String successMessage = (String) request.getAttribute("successMessage");
                %>
                <% if (errorMessage != null) { %>
                    <div class="alert alert-danger">
                        <%= errorMessage %>
                    </div>
                <% } %>
                <% if (successMessage != null) { %>
                    <div class="alert alert-success">
                        <%= successMessage %>
                    </div>
                <% } %>

                <div class="row">
                    <div class="form-group">
                        <label for="regdno">Reg No</label>
                        <input type="text" class="form-control" id="regdno" name="regdno" placeholder="Registration number" required>
                    </div>
                    <div class="form-group">
                        <label for="full_name">Full Name</label>
                        <input type="text" class="form-control" id="full_name" name="full_name" placeholder="Full Name" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone number" required>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="form-group">
                        <label for="branch">Branch</label>
                        <select class="form-control" id="branch" name="branch" required>
                            <option value="" disabled selected>Select your branch</option>
                            <option>BTech</option>
                            <option>BCA</option>
                            <option>MCA</option>
                            <option>MTech</option>
                            <option>MSc</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="college">College</label>
                        <select class="form-control" id="college" name="college" required>
                            <option value="" disabled selected>Select your college</option>
                            <option>ITER</option>
                            <option>IMS</option>
                            <option>Other</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <span class="password-toggle" onclick="togglePasswordVisibility('password')"><i class="fas fa-eye"></i></span>
                    </div>
                    <div class="form-group">
                        <label for="confirm_password">Confirm Password</label>
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm Password" required>
                        <span class="password-toggle" onclick="togglePasswordVisibility('confirm_password')"><i class="fas fa-eye"></i></span>
                    </div>
                </div>
                 <div class="form-group d-flex justify-content-end">
    <button type="submit" class="btn btn-primary">Register</button><br>
    
</div>
                 
    <strong class="mt-3">Already have an account? <a href="userlogin.jsp"><b>Login</b></a></strong> 
  <!--   <small class="form-text text-muted"><b>NOTE:-To Register a complaint please Do sign up First.</b></small> -->           
            </form>
        </div>
    </div>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script>
        function togglePasswordVisibility(id) {
            var passwordField = document.getElementById(id);
            var type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
            var icon = passwordField.nextElementSibling.querySelector('i');
            icon.classList.toggle('fa-eye');
            icon.classList.toggle('fa-eye-slash');
        }
    </script>
</body>
</html>
