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
            String bidId=request.getParameter("bidId");

            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DELETE FROM bidding WHERE auctionId ='" + auctionId + "' AND bidId="+bidId+";");
            

            response.sendRedirect("customerRepPortal.jsp");
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    %>
</body>
</html>
