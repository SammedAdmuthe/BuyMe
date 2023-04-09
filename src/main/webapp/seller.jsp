<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sell Product</title>
</head>
<body>
	<div style="height: 35px; background-color: #ededed; text-align: center; padding-top: 10px;">
		<label style="font-weight: 600; color: #0099ff; font-size: 18px">Earn money!</label>
		<label style="font-weight: 600; color: #00cc99; font-size: 18px">Sell your product by filling the form below.. </label>
	</div><br><br>
	<form method = "post" style="padding: 10px; height: 150px;  border: solid 2px #ededed">
		<div style="display: flex;">
		<div style="width: 35%; display: flex">
				<div>
					<label style="font-weight: 600;">Name:</label>&nbsp;<br><br>
					<label style="font-weight: 600;">Category:</label>&nbsp;<br><br>
					<label style="font-weight: 600;">Minimum Price:</label>&nbsp;<br><br>
				</div>
				<div>
				<input type="text" id="productName" name = "productName" required
				      placeholder="Please enter product name"><br><br>
				      <select name="category" id="category">
					  <option value="Mens">Mens</option>
					  <option value="Womens">Womens</option>
					  <option value="Kids">Kids</option>
					</select><br><br>
					<input type="number" id="minPrice" name = "minPrice" required style="width: 180%"
				      placeholder="Please enter minimum price for the auction"><br><br>
				</div>
				
			</div>
			<div style="width: 50%; display: flex;">
				<div>
					<label style="font-weight: 600;">Minimum Bid Increments:</label>&nbsp;<br><br>
					<label style="font-weight: 600;">Start Time for Auction:</label><br><br>
					<label style="font-weight: 600;">End Time for Auction:</label><br><br>
				</div>
				
				<div>
					<input type="number" id="minIncrement" name = "minIncrement" required
			      placeholder="Please enter minimum bid increment price for the auction"><br><br>	    
		  			<input type="datetime-local" id="auctionStartTime" name="auctionStartTime" required><br><br>	
		  			<input type="datetime-local" id="auctionEndTime" name="auctionEndTime" required><br><br>
				</div>	      
			</div>
		</div>
		<div style="margin-left: 30%">
		    	<input type="submit" id="placeActionSubmit" value="Submit" />	
		</div>
	</form>
	
</body>
</html>