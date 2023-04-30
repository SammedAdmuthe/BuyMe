<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe</title>
</head>
<body>

    <%
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String cpwd = request.getParameter("cpwd");

        if(!pwd.equals(cpwd)){
            response.sendRedirect("staffSignUp.jsp");
        }

        DBHelper dbhelper = new DBHelper();
        Connection connection = dbhelper.getConnection();
        if(connection == null)
        {
            out.println("Connection is null");
        }

        try{
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from STAFF where username = " + "'"+username+"'");
            if(rs.first()) {
                session.setAttribute("errorMessage", "Username already exists");
                response.sendRedirect("staffSignUp.jsp");
            }
            else
            {
                // username, fname, lname, password, dob, address, phone, email
                System.out.println("Inserting into staff table");
                stmt.executeUpdate("insert into staff(username, firstName, lastName, password) values("+ "'"+username+"'" + "," + "'"+fname+"'" + "," + "'"+lname+"'" + "," + "'"+passwordEncrypter.encrypt(pwd)+"'" + ")");

                response.sendRedirect("admin.jsp");
            }
        }catch(Exception e){
            out.println(e);
        }finally{
            dbhelper.closeConnection(connection);
        }

    %>
</body>
</html>