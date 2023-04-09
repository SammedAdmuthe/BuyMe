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
	
	<!-- <input style="width: 94%; margin-left: 10px" type="text" id="myInput" placeholder="Search for names.." title="Type in a name"> -->

	
<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'London')">For Sale</button>
  <button class="tablinks" onclick="openCity(event, 'Paris')">My Listings</button>
</div>

<div id="London" class="tabcontent">
  <%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		try{
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from product p join auction a on p.productId = a.auctionId join category c on c.categoryName = p.categoryName");
			out.println("<div style='width: 100%; height: calc(100vh - 250px);'>");
			out.println("<table style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Initial Price</th><th>Product Image</th><th>Product Category</th><th>Auction Status</th><th>Details</th></tr>");
			while(rs.next()){
				out.println("<tr><td>"+ rs.getString("initialPrice")+"</td>");
				out.println("<td>"+ rs.getString("productImages")+"</td>");
				out.println("<td>"+ rs.getString("categoryName")+"</td>");
				out.println("<td>"+ rs.getString("auctionStatus")+"</td>");

				out.println("<td><a href='product.jsp?auctionid="+rs.getString("auctionId")+"&productid="+ rs.getInt("productId")+"'> Details </td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("<div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%>
</div>

<div id="Paris" class="tabcontent">
  <h3>My Listings</h3>
  <p>Paris is the capital of France.</p> 
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