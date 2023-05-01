<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BuyMe(Admin)</title>
    </head>
<body style="height: 100vh; width: 100vw; margin: 0px;">


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
	
	<div style="padding: 10px; display: flex; justify-content: space-between;">
		<h1>Welcome <span style="color: green"><%= session.getAttribute("username") %></span> to Admin Dashboard!</h1>	
		<a href='staffSignUp.jsp' style="margin-top: 25px"><button style="background: #0099ff; color: white "> Create new Staff User</button></a>
	</div>

    <%
        DBHelper dbhelper = new DBHelper();
        Connection connection = dbhelper.getConnection();
        try{
            Statement statement = connection.createStatement();

            ///////////////////////////////////////////////////
            // Sales report
            ///////////////////////////////////////////////////

            // Button to create a staff user
            out.println("<div style='padding: 50px; text-align: center;'>");
            

            // Total Earnings
            out.println("<div style='display: flex;  margin-left: 22%;'>");
            out.println("<div style='text-align: center; border: solid 1px #ededed; height: 200px; width: 250px'>");
            out.println("<h2>Total Earnings</h2>");
            out.println("<br>");out.println("<br>");
            String sql = "SELECT COUNT('bidPrice') as ct FROM bidding WHERE didWin=1";
            ResultSet rs = statement.executeQuery(sql);
            while(rs.next()){
                String total_sales = rs.getString("ct");
                out.println("<h1>"+total_sales+"</h1>");
                
            }
            
            out.println("</div>");

            // Earnings per item
           
            out.println("<div style='text-align: center; border: solid 1px #ededed; height: 200px; width: 250px'>");
            out.println("<h2>Earnings per item</h2>");           
            out.println("<br>");out.println("<br>");
            sql = "WITH T1 AS ( SELECT P.productName as productName, B.bidPrice as price FROM product as P natural join auction as A natural join bidding as B where B.didWin = 1 ) SELECT T1.productName as product, sum(T1.price) as price FROM T1 GROUP BY T1.productName ORDER BY sum(T1.price) DESC";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String product_name = rs.getString("product");
                int earnings = rs.getInt("price");
                out.println(product_name + ": " + earnings);
                
            }
		
            out.println("</div>");


            // Earnings per Item Type
            out.println("<div style='text-align: center; border: solid 1px #ededed; height: 200px; width: 250px'>");
            out.println("<h2>Earnings per Item Type</h2>");
            sql = "WITH T1 as ( select C.categoryName, B.bidPrice from category as C natural join product as P natural join auction as A natural join bidding as B where didWin = 1 ) SELECT T1.categoryName as category, sum(T1.bidPrice) as earnings FROM T1 GROUP BY T1.categoryName ORDER BY sum(T1.bidPrice) DESC";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String category_name = rs.getString("category");
                int earnings = rs.getInt("earnings");
                out.println(category_name + " " + earnings);
                out.println("<br>");
            }

            out.println("</div>");
            out.println("</div>");


            // Earnings per Seller
            out.println("<div style='display: flex; margin-left: 22%;'>");
            out.println("<div style='text-align: center; border: solid 1px #ededed; height: 200px; width: 250px'>");
            out.println("<h2>Earnings per Seller</h2>");
            sql = "WITH T1 AS ( SELECT A.username as username, B.bidPrice as price from auction as A natural join bidding as B where B.didWin = 1 ) SELECT T1.username, sum(T1.price) as earnings FROM T1 GROUP BY T1.username ORDER BY sum(T1.price) DESC;";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String username = rs.getString("username");
                int earnings = rs.getInt("earnings");
                out.println(username + " " + earnings);
                out.println("<br>");
            }

            out.println("</div>");


            // Best Selling Item
            out.println("<div style='text-align: center; border: solid 1px #ededed; height: 200px; width: 250px'>");
            out.println("<h2>Best Selling Item</h2>");
            sql = "WITH T1 as ( SELECT P.productName as productName, B.bidPrice as price FROM bidding as B NATURAL JOIN auction as A NATURAL JOIN product as P WHERE B.didWin=1 ) SELECT T1.productName as product, sum(T1.price) as earnings FROM T1 GROUP BY T1.productName ORDER BY sum(T1.price) DESC";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String product_name = rs.getString("product");
                int maxCount = rs.getInt("earnings");
                out.println(product_name + " " + maxCount);
                out.println("<br>");
            }


            out.println("</div>");


            // Best Buyers
            out.println("<div style='text-align: center; border: solid 1px #ededed; height: 200px; width: 250px'>");
            out.println("<h2>Best Buyers</h2>");
            sql = "WITH T1 as ( SELECT A.username, B.bidPrice as price FROM auction as A NATURAL JOIN bidding as B WHERE B.didWin = 1 ) SELECT T1.username as username, sum(T1.price) as earnings FROM T1 group by T1.username ORDER BY sum(T1.price) DESC LIMIT 5";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String username = rs.getString("username");
                int earnings = rs.getInt("earnings");
                out.println(username + " " + earnings);
                out.println("<br>");
            }
            out.println("</div>");
            out.println("</div>");
            
            out.println("</div>");

        }catch(Exception e){
 		    out.println(e.getMessage());
 	    }
    %>
</body>
</html>