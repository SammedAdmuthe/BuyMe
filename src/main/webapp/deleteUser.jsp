<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete User</title>
</head>
<body>
		  <%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		
		try{
	        String username = request.getParameter("username");

			Statement stmt = connection.createStatement();
			stmt.executeUpdate("DELETE FROM enduser WHERE username ='"+username+"'");
			response.sendRedirect("customerRepPortal.jsp");


		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%>
</body>
</html>