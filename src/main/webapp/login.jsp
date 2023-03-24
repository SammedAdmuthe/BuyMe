<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
/* 	DBHelper dbhelper = new DBHelper();
 */
 	String username = request.getParameter("username");
	String password	= request.getParameter("pwd");
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	
/* 	out.println(connection);
 *//* 	out.println(password);
 */	
	Statement stmt = connection.createStatement();
 	ResultSet rs = stmt.executeQuery("select * from users where username = " + "'"+username+"'"+" and password = "+ "'"+password+"'");

	System.out.println(rs.first());
 	if(rs.first()) {
		out.println("Login Success");
	}
	else
	{
		out.println("Login Failed");
	}
	dbhelper.closeConnection(connection);
%>