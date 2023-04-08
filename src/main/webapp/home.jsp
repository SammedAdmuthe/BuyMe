<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage</title>
</head>
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
#myInput {
  background-image: url('https://www.w3schools.com/css/searchicon.png');
  background-position: 10px 10px;
  background-repeat: no-repeat;
  font-size: 16px;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin-bottom: 12px;
}

</style>
<body style="height: 100vh; width: 100vw; margin: 0px;">

	<%
		//String sessionUser = (String)session.getAttribute("username");
		//System.out.println(sessionUser);
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader ("Expires", 0);
		if(session.getAttribute("username")==null){
			System.out.println("Session does not exist, redirecting to login page");
			response.sendRedirect("index.jsp");
		}
	%>
	
	<div style="display: flex; height:45px; background-color: #ededed; justify-content: space-between;">
		<div style="display: flex;">
			<label style="padding: 10px 0 0 10px; color: #0099ff; font-size: 20px;">Buy</label>
			<label style="padding: 10px 0 0 0; color: #00cc99; font-size: 20px;">Me</label>
			<label style="padding: 10px 0 0 0; color: #0099ff; font-size: 20px;">!</label>
		</div>			
		
		
		<form method="post" action="logout.jsp">
		    <input style="margin-top: 10px; margin-right: 10px;" type="submit" value="Logout">
		</form>
	</div>
	<div style="padding: 10px;">
		<h1>Welcome <%= session.getAttribute("username") %>!</h1>
	</div>
	<input style="width: 94%; margin-left: 10px" type="text" id="myInput" placeholder="Search for names.." title="Type in a name">
	<%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		try{
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from product p join auction a on p.productId = a.auctionId join category c on c.categoryId = p.categoryId");
			out.println("<div style='width: 100%; height: calc(100vh - 250px);'>");
			out.println("<table style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Initial Price</th><th>Product Image</th><th>Product Category</th><th>Auction Status</th><th>Details</th></tr>");
			while(rs.next()){
				out.println("<tr><td>"+ rs.getString("initialPrice")+"</td>");
				out.println("<td>"+ rs.getString("productImages")+"</td>");
				out.println("<td>"+ rs.getString("categoryName")+"</td>");
				out.println("<td>"+ rs.getString("auctionStatus")+"</td>");

				out.println("<td><a href='product.jsp?productid="+ rs.getInt("productId")+"'> Details </td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("<div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%>
	
	<div>
		
	</div>
		
</body>
</html>