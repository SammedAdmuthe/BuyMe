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
		
	</div>
	
	<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'allUsers')">All Users</button>
  <button class="tablinks" onclick="openCity(event, 'userQueries')">User Queries</button>
  <button class="tablinks" onclick="openCity(event, 'allAuctions')">All Auctions</button>

</div>

<div id="allUsers" class="tabcontent">
	  <%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		try{
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from enduser");
			out.println("<div style='width: 100%;'>");
			out.println("<table id='myListingsTable'  style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>User Name</th><th>First Name</th><th>Last Name</th><th>Date of Birth</th><th> Address</th><th>Phone no</th><th>Email Address</th></tr>");
			
			while(rs.next()){
				out.println("<tr><td>"+ rs.getString("username")+"</td>");
				out.println("<td>"+ rs.getString("firstName")+"</td>");
				out.println("<td>"+ rs.getString("lastName")+"</td>");
				out.println("<td>"+ rs.getString("dob")+"</td>");
				out.println("<td>"+ rs.getString("address")+"</td>");
				out.println("<td>"+ rs.getString("phoneNo")+"</td>");
				out.println("<td>"+ rs.getString("emailId")+"</td>");
				out.println("<td>"+ "<a href='editUser.jsp?username="+rs.getString("username")+"'> Edit </td>");
				out.println("<td>"+ "<a href='deleteUser.jsp?username="+rs.getString("username")+"'> Delete </td>");
			}
			out.println("</table>");
			out.println("</div>");
		}
		catch(Exception e){
	 		out.println(e.getMessage());

		}
	%>
</div>

<div id="userQueries" class="tabcontent">
<div style="width: 100%; margin-top: 10px;">
	 <%
		DBHelper db1 = new DBHelper();	
		Connection connection1 = db1.getConnection();
		String idName = "entry";
		try{
			Statement stmt1 = connection1.createStatement();
			ResultSet rs1 = stmt1.executeQuery("SELECT * from userqueries;");
			out.println("<div style='width: 100%;'>");
			//out.println("");
			out.println("<table id='userQueriesTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>User</th><th>Query</th><th>Resolution and Query Status</th></tr>");
			while(rs1.next()){
				out.println("<tr><td>"+ rs1.getString("username")+"</td>");
				out.println("<td>"+ rs1.getString("query")+"</td>");		
				if(Integer.parseInt(rs1.getString("queryStatus")) == 0){
					out.println("<td> <form method='post' style='display:flex; justify-content: space-between' action='resolveQuery.jsp?queryid="
				+rs1.getString("queryId")+"'> <input placeholder='Enter answer' id='"+idName+rs1.getString("queryId")
				+"' name='"+idName+rs1.getString("queryId")+"'/>&nbsp; &nbsp;<input  type='submit' value = 'Submit and Mark Resolved'> </form></td>");
					
				}
				else{
					out.println("<td><div style='display:flex; justify-content: space-between'><span style='margin-left: 0px'><b>Resolution:</b>"+ rs1.getString("answer")+"</span>&nbsp; &nbsp; <span><b>Status:</b>Resolved</span></div></td>");
				}
				
				out.println("</tr>");
			}
			out.println("</table>");
			//out.println("</form>");
			out.println("</div>");
			
		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%> 
	</div>
</div>

<div id="allAuctions" class="tabcontent">
<div style="width: 100%; margin-top: 10px;">
	 <%
		DBHelper db2 = new DBHelper();	
		Connection connection2 = db1.getConnection();
		String idName1 = "entry";
		try{
			Statement stmt2 = connection1.createStatement();
			ResultSet rs2 = stmt2.executeQuery("SELECT * from auction;");
			out.println("<div style='width: 100%;'>");
			//out.println("");
			out.println("<table id='allAuctionsTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>User</th><th>AuctionId</th><th>Take Action</th></tr>");
			while(rs2.next()){
				out.println("<tr><td>"+ rs2.getString("username")+"</td>");
				out.println("<td>"+ rs2.getInt("auctionId")+"</td>");		
				out.println("<td>"+ "<a href='deleteAuction.jsp?auctionId="+rs2.getInt("auctionId")+"'> Delete </td>");
				out.println("</tr>");
			}
			out.println("</table>");
			//out.println("</form>");
			out.println("</div>");
			
		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%> 
	</div>
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