<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>

<% 
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String username = request.getParameter("username");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String dob = request.getParameter("dob");
String email = request.getParameter("email");
String pwd = request.getParameter("pwd");
String cpwd = request.getParameter("cpwd");

if(fname == null || lname == null || username == null || address == null || phone == null || dob == null || email == null || pwd == null || cpwd == null)
{
    response.sendRedirect("signup.jsp");
}

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
        stmt.executeUpdate("insert into enduser values(" + "'"+fname+"'" + "," + "'"+lname+"'" + "," + "'"+username+"'" + "," + "'"+address+"'" + "," + "'"+phone+"'" + "," + "'"+dob+"'" + "," + "'"+email+"'" + "," + "'"+pwd+"'" + ")");
        session.setAttribute("username",username);
        response.sendRedirect("home.jsp");
    }
}catch(Exception e){
    if(connection == null){
    out.println("Connection is null");
}else{
    out.println(e.getMessage());
}
}
dbhelper.closeConnection(connection);
%>