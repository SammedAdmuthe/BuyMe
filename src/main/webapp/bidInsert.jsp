<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.BidSystem" %>
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
		String mybid = request.getParameter("mybid");
		String upperLimit = request.getParameter("uplimit");
		ResultSet rs = stmt.executeQuery("select * from bidding where username = " + "'"+username+"' and"+" auctionId = '"+auctionId+"'" );
		
		rs.last();
		int no_records = rs.getRow();
		rs.first();
		
		rs =stmt.executeQuery("select currentMaxBid from auction where auctionId = '"+auctionId+"'");
		rs.next();
		
		int currentMaxBid = rs.getInt("currentMaxBid");
/* 		out.println(currentMaxBid);
 */		if(no_records > 0)
		{
			PreparedStatement ps1 = connection.prepareStatement("update bidding set bidPrice=?, upperLimit=? where username = ?");
			ps1.setString(1, mybid);
			ps1.setString(2, upperLimit);
			ps1.setString(3, username);
			ps1.executeUpdate();

		}
		else
		{
			int rs1 = stmt.executeUpdate("insert into bidding(auctionId, username, bidPrice, upperLimit) values("+"'"+auctionId+"',"+"'"+username+"',"+"'"+mybid+"', '"+upperLimit+"'"+")");
		}
		stmt.executeUpdate("update auction set currentMaxBid = '"+mybid+"' where auctionId = '" + auctionId +"'");
/* 		response.sendRedirect("home.jsp");
 */
 	BidSystem bs=new BidSystem();
 	bs.AutoBid();
	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	%>
</body>
</html>