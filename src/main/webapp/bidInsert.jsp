<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
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
	
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	try{
		Statement stmt = connection.createStatement();
		String auctionId = request.getParameter("auctionId");
		String username = request.getParameter("username");
		String bidId = request.getParameter("bidId");
		String mybid = request.getParameter("mybid");
		String upperLimit = request.getParameter("uplimit");
		int rs = stmt.executeUpdate("insert into bidding(bidId, auctionId, username, bidPrice, upperLimit) values("+"'"+bidId+"',"+"'"+auctionId+"',"+"'"+username+"',"+"'"+mybid+"', '"+upperLimit+"'"+")");
		response.sendRedirect("home.jsp");

	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	%>
</body>
</html>