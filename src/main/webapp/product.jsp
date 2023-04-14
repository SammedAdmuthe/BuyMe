<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.AddressException" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>

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
	ResultSet rs1 = stmt.executeQuery("select currentMaxBid, incrementPrice, initialPrice from auction where auctionId = " + "'"+auctionId+"'");
	rs1.next();
 	int currentMaxBid = rs1.getInt("currentMaxBid");
 	int increment = rs1.getInt("incrementPrice");
 	int initialPrice = rs1.getInt("initialPrice");
 	rs1 = stmt.executeQuery("select maxBidUserName from auction where auctionId = " + "'"+auctionId+"'");
 	rs1.next();
 	String maxBidUserName = rs1.getString("maxBidUserName");
 	
/*  	out.println(maxBidUserName);
 */
 	int newBid = currentMaxBid;
 	if(newBid == 0) {
 		newBid = initialPrice-increment; // This takes care of increment for the first time bid by any user.
 	}
	%>
	<form action="bidInsert.jsp" method="post">
		  <label for="currentbid">Current Bid on this product :</label><br>
		  <input type="text" id="currentbid" name="currentbid" disabled value = "<%=currentMaxBid%>"><br>
		  <!-- <label for="myBid">Put your bid higher than current bid:</label><br>
		  <input type="text" id="myBid" name="myBid"><br> -->
		  <input type="text" id="mybid" name="mybid" hidden value = "<%=newBid + increment%>">
		  <label for="uplimit">Enter Upper Limit</label><br>
		  <input type="text" id="uplimit" name="uplimit"><br>
		  
		  <input type="text" id="auctionId" name="auctionId" hidden value = "<%=auctionId%>">
		  <input type="text" id="username" name="username" hidden value = "<%=session.getAttribute("username")%>">
		 
		  <%if(session.getAttribute("username").equals(maxBidUserName)){ %>
		   <input type="submit" disabled value = "Set New Bid for $<%=newBid + increment%>">
		  <%} else {%>
		  	<input type="submit" value = "Set New Bid  for $<%=newBid + increment%>">
		  <% }%>
		 
	</form>
</body>
</html>