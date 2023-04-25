<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>


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

.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
  height: calc(100vh - 250px);
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
		<h1>Welcome <span style="color: green"><%= session.getAttribute("username") %></span>!</h1>
		<div style="display: flex;">
			<span>Ready to sell a product?</span> &nbsp;
			<a href='seller.jsp'> Click here!</a>
		</div>		
	</div>
	
	<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'myListings')">My Listings</button>
  <button class="tablinks" onclick="openCity(event, 'forSale')">For Sale</button>
  <button class="tablinks" onclick="openCity(event, 'myBids')">My Bids</button>
</div>

<div id="myListings" class="tabcontent">
  <%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		try{
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from product p join auction a on p.productId = a.productId join category c on c.categoryName = p.categoryName where p.username='"+session.getAttribute("username")+"';");
			out.println("<div style='width: 100%;'>");
			out.println("<table style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Product Name</th><th>Product Image</th><th>Initial Price</th><th>Product Category</th><th>Auction Status</th><th>Details</th></tr>");
			while(rs.next()){
			    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			    
			    LocalDateTime nowDateTime = LocalDateTime.now();
/* 			    dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
 */			    
/*  				LocalDateTime nowDate = LocalDateTime.now(); */
 /* 				   System.out.println("GETer" + dtf.format(now));  
 */				/* 
 				System.out.println(rs.getTime("startTime"));
 				System.out.println(rs.getDate("startTime"));
 				System.out.println(); */
/*  				System.out.println(nowTime.toLocalTime());
 */ 				
 				LocalDate currentDate = nowDateTime.toLocalDate();
 				LocalTime currentTime = nowDateTime.toLocalTime();
 				
			    LocalDateTime scheduleDateTime = rs.getTimestamp("startTime").toLocalDateTime();
			    
			    LocalDate scheduleDate = scheduleDateTime.toLocalDate();
 				LocalTime scheduleTime = scheduleDateTime.toLocalTime();
 				
/*  				System.out.println(scheduleDate.compareTo(currentDate));
 				System.out.println(currentTime.compareTo(scheduleTime));
 				 */

/* 			    SimpleDateFormat formatter6=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");  

				String scheduleStart = rs.getString("startTime");
				System.out.println("HERE !! "+ formatter6); */
				out.println("<tr><td>"+ rs.getString("productName")+"</td>");
				out.println("<td>"+ rs.getString("productImages")+"</td>");
				out.println("<td>"+ rs.getString("initialPrice")+"</td>");
				out.println("<td>"+ rs.getString("categoryName")+"</td>");
				out.println("<td>"+ rs.getString("auctionStatus")+"</td>");
				
				out.println("<td><a href='product.jsp?auctionid="+rs.getString("auctionId")+"&productid="+ rs.getInt("productId")+"'> Details </td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("</div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%>
</div>

<div id="forSale" class="tabcontent">
  <%
		DBHelper db1 = new DBHelper();	
		Connection connection1 = db1.getConnection();
		try{
			Statement stmt1 = connection1.createStatement();
			ResultSet rs1 = stmt1.executeQuery("Select * from product p join auction a on p.productId = a.productId join category c on c.categoryName = p.categoryName");
			out.println("<div style='width: 100%;'>");
			out.println("<table style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Product Name</th><th>Product Image</th><th>Initial Price</th><th>Product Category</th><th>Auction Status</th><th>Details</th></tr>");
			
			while(rs1.next()){
			    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			    
			    LocalDateTime nowDateTime = LocalDateTime.now();				
 				LocalDate currentDate = nowDateTime.toLocalDate();
 				LocalTime currentTime = nowDateTime.toLocalTime();
 				
			    LocalDateTime scheduleDateTime = rs1.getTimestamp("startTime").toLocalDateTime();
			    LocalDate scheduleDate = scheduleDateTime.toLocalDate();
 				LocalTime scheduleTime = scheduleDateTime.toLocalTime();
 				
			    LocalDateTime scheduleEndDateTime = rs1.getTimestamp("endTime").toLocalDateTime();
 				LocalDate scheduleEndDate = scheduleEndDateTime.toLocalDate();
 				LocalTime scheduleEndTime = scheduleEndDateTime.toLocalTime();
 				System.out.println(scheduleEndDate.compareTo(currentDate));
 				System.out.println(scheduleEndTime.compareTo(currentTime));
 				
				out.println("<tr><td>"+ rs1.getString("productName")+"</td>");
				out.println("<td>"+ rs1.getString("productImages")+"</td>");
				out.println("<td>"+ rs1.getString("initialPrice")+"</td>");
				out.println("<td>"+ rs1.getString("categoryName")+"</td>");
				out.println("<td>"+ rs1.getString("auctionStatus")+"</td>");
				
				if((scheduleDate.compareTo(currentDate)<=0 && scheduleEndDate.compareTo(currentDate)>=0) && (scheduleTime.compareTo(currentTime)<=0 && scheduleEndTime.compareTo(currentTime)==1))  //auction start
					out.println("<td><a href='product.jsp?auctionid="+rs1.getString("auctionId")+"&productid="+ rs1.getInt("productId")+"'> Details </td>");
				else if((scheduleEndDate.compareTo(currentDate) < 0) || (scheduleEndDate.compareTo(currentDate)<=0 && scheduleEndTime.compareTo(currentTime)<=0)) // auction stopped
				{
					int currentMax = rs1.getInt("currentMaxBid");
					float secretMinBid = rs1.getFloat("secretMinimumBid");
					
					if(secretMinBid <= currentMax)
					{
						//Bid won by maxBidUserName
						out.println("<td><a href='product.jsp?auctionid="+rs1.getString("auctionId")+"&productid="+ rs1.getInt("productId")+"'> Bid won by "+rs1.getString("maxBidUserName")+" </td>");
					}
					else
					{
						out.println("<td> No winner </td>");
					}
				}
				else {
					out.println("<td>Will be live soon</td>");

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
</div>

<div id="myBids" class="tabcontent">

  <%
		DBHelper db2 = new DBHelper();	
		Connection connection2 = db2.getConnection();
		try{
			Statement stmt2 = connection2.createStatement();
			ResultSet rs2 = stmt2.executeQuery("SELECT p.productId, a.auctionId, p.productImages, p.productName, a.auctionStatus, a.currentMaxBid, b.upperLimit, b.bidPrice FROM bidding b JOIN auction a ON b.auctionId = a.auctionId JOIN product p ON a.productId = p.productId WHERE a.endTime > NOW() AND b.username='"+session.getAttribute("username")+"';");
			out.println("<div style='width: 100%;'>");
			out.println("<table style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Product Name</th><th>Product Image</th><th>Auction Status</th><th>Current Max Bid</th><th>Your Bid</th></th><th>Your Upper Limit</th></tr>");
			while(rs2.next()){
				out.println("<tr><td>"+ rs2.getString("productName")+"</td>");
				out.println("<td>"+ rs2.getString("productImages")+"</td>");
				out.println("<td>"+ rs2.getString("auctionStatus")+"</td>");
				out.println("<td>"+ rs2.getString("currentMaxBid")+"</td>");
				out.println("<td>"+ rs2.getString("bidPrice")+"</td>");
				out.println("<td>"+ rs2.getString("upperLimit")+"</td>");

				out.println("<td><a href='product.jsp?auctionid="+rs2.getString("auctionId")+"&productid="+ rs2.getInt("productId")+"'> Details </td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("</div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%> 
</div>
	
		
</body>

<script>
function openCity(evt, cityName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
  
}
</script>
</html>