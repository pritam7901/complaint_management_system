<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
            background: url('iter.jpg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(-1px);
        }

        .container {
            max-width: 400px;
            width: 100%;
            padding: 30px;
            background: rgba(255, 255, 255, 0.85);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            z-index: 1;
        }

        h3 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 15px;
            padding-left: 40px;
        }

        .btn-primary {
            background-color: blue;
            border: none;
            font-weight: bold;
            border-radius: 10px;
        }

        .btn-primary:hover {
            background-color: green;
        }

        .btn-secondary {
            border: none;
            font-weight: bold;
            border-radius: 10px;
        }

        .icon {
            position: absolute;
            left: 15px;
            top: 70%;
            transform: translateY(-50%);
            color: #999;
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

        .btn-wrapper {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

        .btn {
            flex: 1;
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <div class="container">
        <h3><b>User Login</b></h3>
        <form action="userloginprocess.jsp" method="post" onsubmit="return validateLogin()">
            <div class="form-group position-relative">
                <label for="email">User ID</label>
                <input type="text" class="form-control" id="email" name="email" placeholder=" Registration no" required>
                <span class="icon"><i class="fas fa-user"></i></span>
            </div>
            <div class="form-group position-relative">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                <span class="icon"><i class="fas fa-key"></i></span>
                <span class="password-toggle" onclick="togglePassword()"><i class="fas fa-eye"></i></span>
            </div>
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <p class="error-message"><%= errorMessage %></p>
            <% } %>
            <div class="btn-wrapper">
                <button type="button" class="btn btn-secondary" onclick="window.location.href='main.jsp'">Cancel</button>
                <button type="submit" class="btn btn-primary">Login</button>
            </div>
        </form>
        <p class="text-center mt-3"><b>Don't have an account? </b><a href="signup.jsp"><b>Sign up</b></a></p>
        <p class="text-center mt-2"><a href="forgotpassword.jsp"><b>Forgot Password?</b></a></p>
          
    </div>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const icon = passwordField.nextElementSibling.nextElementSibling;
            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.innerHTML = '<i class="fas fa-eye-slash"></i>';
            } else {
                passwordField.type = "password";
                icon.innerHTML = '<i class="fas fa-eye"></i>';
            }
        }

        function validateLogin() {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const errorMessage = document.querySelector('.error-message');

            if (!email || !password) {
                errorMessage.style.display = 'block';
                errorMessage.innerHTML = 'Please enter your email and password.';
                return false;
            }
            errorMessage.style.display = 'none';
            return true;
        }
    </script>
</body>
</html>
