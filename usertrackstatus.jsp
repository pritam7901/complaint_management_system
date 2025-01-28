 <!DOCTYPE html>
<html>
<head>
    <title>Track Grievance Status</title>
     <!-- Link to your CSS file -->
</head>
<style>
/* styles.css */

/* General Styles */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f9;
    color: #333;
    margin: 0;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
}

h1 {
    color: #0056b3;
    font-size: 2em;
    margin-bottom: 20px;
}

form {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

label {
    font-weight: bold;
    margin-bottom: 10px;
    width: 100%;
    text-align: left;
}

input[type="text"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1em;
}

input[type="submit"] {
    background-color: #0056b3;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #004494;
}

a {
    color: #0056b3;
    text-decoration: none;
    margin-top: 20px;
    font-weight: bold;
    transition: color 0.3s ease;
}

a:hover {
    color: #004494;
}

/* Responsive Design */
@media (max-width: 480px) {
    h1 {
        font-size: 1.5em;
    }

    form {
        padding: 15px;
    }

    input[type="text"], input[type="submit"] {
        font-size: 0.9em;
    }
}

</style>
<body>
    <h1>Track Your Grievance Status</h1>
    <form action="userTSprocess.jsp" method="post">
        <label for="grievanceId">Enter Grievance ID:</label>
        <input type="text" id="grievanceId" name="grievanceId" required>
        <input type="submit" value="Track Status">
    </form>
    <br>
    <a href="userdashboard.jsp">Back to dasboard</a>
</body>
</html>
 