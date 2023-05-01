<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="com.dbhelper.*" %>
<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Auction</title>
</head>
<body>
    <%
        DBHelper db = new DBHelper();
        Connection connection = db.getConnection();

        try {
            String auctionId = request.getParameter("auctionId");

            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DELETE FROM auction WHERE auctionId ='" + auctionId + "'");
            
            Statement stmt1 = connection.createStatement();
            stmt1.executeUpdate("DELETE FROM alerts WHERE auctionId = " + auctionId);
            
 /*            Statement stmt2 = connection.createStatement();
            stmt2.executeUpdate("DELETE FROM bidding WHERE auctionId = " + auctionId); */

            response.sendRedirect("customerRepPortal.jsp");
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    %>
</body>
</html>
