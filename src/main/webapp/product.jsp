<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Details Page</title>
</head>
<body>
	<%
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	Statement stmt = connection.createStatement();
	String productID = request.getParameter("productid");
 	ResultSet rs = stmt.executeQuery("select * from product where productId = " + "'"+productID+"'");
	while(rs.next()){
		out.println("Dimension - " + rs.getString("dimensions")+"</br>");
		out.println("Weight - " + rs.getString("weight") +"</br>");
		out.println("ProductImages - " + rs.getString("productImages") +"</br>");
/* 		out.println(rs.getString("dimensions"));
 */	}
	String auctionId = request.getParameter("auctionid");
	out.println(auctionId);
	ResultSet rs1 = stmt.executeQuery("select currentMaxBid from auction where auctionId = " + "'"+auctionId+"'");
	rs1.next();
 	int currentMaxBid = rs1.getInt("currentMaxBid");
	%>
	<form action="bidInsert.jsp" method="get">
		  <label for="currentbid">Current Bid on this product :</label><br>
 		  <input type="text" id="currentbid" disabled value = "<%=currentMaxBid%>" name="currentbid"><br>
		  <label for="myBid">Put your bid higher than current bid:</label><br>
		  <input type="text" id="myBid" name="myBid"><br>
		  <input type="text" id="auctionId" name="auctionId" hidden value = "<%=auctionId%>">
		  <input type="text" id="username" name="username" hidden value = "<%=session.getAttribute("username")%>">
		  <input type="text" id="bidId" name="bidId" hidden value = "1">
		  <input type="submit" value = "Submit a Bid">
		 
	</form>
</body>
</html>