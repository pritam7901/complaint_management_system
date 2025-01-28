<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    String dbUsername = null;
    String dbPassword = null;
    boolean isValidUser = false;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmpdb", "root", "Password@123");
        PreparedStatement ps = conn.prepareStatement("SELECT username, password FROM admin_data WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            dbUsername = rs.getString("username");
            dbPassword = rs.getString("password");

            if (username.equals(dbUsername) && password.equals(dbPassword)) {
                isValidUser = true;
            }
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (isValidUser) {
        response.sendRedirect("admindashboard.jsp"); // Redirect to admin dashboard on success
    } else {
        response.sendRedirect("adminlogin.jsp?error=true"); // Redirect to login page with error message
    }
%>
