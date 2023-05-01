<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update</title>
</head>
<body>
	  <%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		
		try{
	        String username = request.getParameter("username");
	        String fname = request.getParameter("fname");
	        String lname = request.getParameter("lname");
	        String address = request.getParameter("address");
	        String phone = request.getParameter("phone");
	        String dob = request.getParameter("dob");
	        String email = request.getParameter("email");	
	        PreparedStatement ps1 = connection.prepareStatement("update enduser set firstName = ?, lastName=?, address=?, phoneNo=?, dob=?, emailId=? where username = ?");
			ps1.setString(1, fname);
			ps1.setString(2, lname);
			ps1.setString(3, address);
			ps1.setString(4, phone);
			ps1.setString(5, dob);
			ps1.setString(6, email);
			ps1.setString(7, username);
			
			ps1.executeUpdate();
			response.sendRedirect("customerRepPortal.jsp");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%>
</body>
</html>