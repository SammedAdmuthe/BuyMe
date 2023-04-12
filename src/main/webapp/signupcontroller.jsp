<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Bid Info</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String cpwd = request.getParameter("cpwd");

        if(!pwd.equals(cpwd))
        {
            response.sendRedirect("signup.jsp");
        }

        DBHelper dbhelper = new DBHelper();
        Connection connection = dbhelper.getConnection();
        if(connection == null)
        {
            out.println("Connection is null");
        }

        try{
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from enduser where username = " + "'"+username+"'");
            if(rs.first()) {
                response.sendRedirect("signup.jsp");
            }
            else
            {
                // username, fname, lname, password, dob, address, phone, email
                stmt.executeupdate("insert into enduser(username, firstName, lastName, password, dob, address, phoneNo, emailId) values("+ "'"+username+"'" + "," + "'"+fname+"'" + "," + "'"+lname+"'" + "," + "'"+pwd+"'" + "," + "'"+dob+"'" + "," + "'"+address+"'" + "," + "'"+phone+"'" + "," + "'"+email+"'" + ")");
                session.setAttribute("username",username);
                response.sendRedirect("home.jsp");
            }
        }catch(Exception e){
            out.println(e);
        }finally{
            dbhelper.closeConnection(connection);
        }
    %>
</body>