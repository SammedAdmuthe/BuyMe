<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page language="java"  import="java.time.format.DateTimeFormatter.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit </title>
</head>
<body>
	<%
	
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	try{
		Statement stmt = connection.createStatement();
		String username = request.getParameter("username");
		String productName = request.getParameter("productName");
		String category = request.getParameter("category");
		String startingPrice = request.getParameter("startingPrice");
		String secretPrice = request.getParameter("secretPrice");
		String minIncrement = request.getParameter("minIncrement");
		String auctionStartTime = request.getParameter("auctionStartTime");
		String auctionEndTime = request.getParameter("auctionEndTime");
		
		
		
         //DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"); 

		
		int rs = stmt.executeUpdate("insert into auction(auctionId, productId, username, initialPrice, secretMinimumBid, incrementPrice, startTime, endTime) values(5,4,"+"'"+username+"',"+"'"+startingPrice+"',"+"'"+secretPrice+"',"+"'"+minIncrement+"','"+auctionStartTime+"','"+auctionEndTime+"')");
		//response.sendRedirect("home.jsp");
		response.sendRedirect("home.jsp");


	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	%>
</body>
</html>