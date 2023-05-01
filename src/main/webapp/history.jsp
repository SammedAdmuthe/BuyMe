<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product History</title>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th {
  background-color: #96D4D4;
}

td{
	text-align: center;
}
</style>
</head>
<body>
	<%
	DBHelper dbhelper = new DBHelper();
	Connection connection2 = dbhelper.getConnection();
	
	String auctionID = request.getParameter("auctionId");
 	
 	System.out.println(auctionID);
 	try{
 		Statement stmt2 = connection2.createStatement();
		ResultSet rs2 = stmt2.executeQuery("select * from bidding where auctionId = " + "'"+auctionID+"'");
		out.println("<div style='width: 100%;'>");
		out.println("<table id='biddersTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Bidder</th><th>Bid Price</th><th>Is Winner?</th></tr>");

		while(rs2.next()){
			out.println("<tr><td>"+ rs2.getString("username")+"</td>");
			out.println("<td>"+ rs2.getString("bidPrice")+"</td>");
			
			if(rs2.getString("didWin") == null){
				out.println("<td>No</td>");
			}
			else{
				out.println("<td>"+ rs2.getString("didWin")+"</td>");
			}			
			out.println("</tr>");
		}
		out.println("</table>");
		out.println("</div>");

	}
	catch (Exception e) {
 		out.println(e.getMessage());

	}
		
	%>
</body>
</html>