<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BuyMe</title>
    </head>
<body>

    <%
        DBHelper dbhelper = new DBHelper();
        Connection connection = dbhelper.getConnection();
        try{
            Statement statement = connection.createStatement();

            ///////////////////////////////////////////////////
            // Sales report
            ///////////////////////////////////////////////////


            // Total Earnings
            String sql = "SELECT COUNT('bidPrice') as ct FROM bidding WHERE didWin=1";
            ResultSet rs = statement.executeQuery(sql);
            while(rs.next()){
                String total_sales = rs.getString("ct");
                out.println(total_sales);
            }

            
            // Earnings per item
            sql = "WITH T1 as (SELECT bidding.auctionId, bidding.bidPrice FROM bidding as bidding where bidding.didWin = 1), T2 as (SELECT T1.auctionId, sum(T1.bidPrice) as price FROM T1 GROUP BY T1.auctionId) SELECT P.productName as product, T2.price as earnings FROM T2, auction as A, product as P WHERE T2.auctionId = A.auctionId AND A.productId = P.productId";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String product_name = rs.getString("product");
                int earnings = rs.getInt("earnings");
                out.println(product_name + " " + earnings);
            }




            // Earnings per Item Type
            sql = "WITH T1 as (SELECT bidding.auctionId, bidding.bidPrice FROM bidding as bidding where bidding.didWin = 1), T2 as (SELECT T1.auctionId, sum(T1.bidPrice) as price FROM T1 GROUP BY T1.auctionId) SELECT C.categoryName as category, T2.price as earnings FROM T2, auction as A, product as P, category as C WHERE T2.auctionId = A.auctionId AND A.productId = P.productId AND P.categoryName = C.categoryName";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String category_name = rs.getString("category");
                int earnings = rs.getInt("earnings");
                out.println(category_name + " " + earnings);
            }



            // Earnings per Seller
            sql = "WITH T1 as (SELECT bidding.auctionId, bidding.bidPrice FROM bidding as bidding where bidding.didWin = 1), T2 as (SELECT T1.auctionId, sum(T1.bidPrice) as price FROM T1 GROUP BY T1.auctionId) SELECT A.username as username, T2.price as earnings FROM T2, auction as A WHERE T2.auctionId = A.auctionId";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String username = rs.getString("username");
                int earnings = rs.getInt("earnings");
                out.println(username + " " + earnings);
            }




            // Best Selling Item
            sql = "WITH T1 AS (SELECT bidding.auctionId, bidding.bidPrice FROM bidding AS bidding WHERE bidding.didWin = 1), T2 AS (SELECT T1.auctionId, count(T1.bidPrice) AS maxCount FROM T1 GROUP BY T1.auctionId), T3 AS (SELECT DISTINCT X.auctionId, X.maxCount FROM T2 AS X, T2 AS Y WHERE X.maxCount >= Y.maxCount) SELECT P.productName as product, T3.maxCount as count FROM T3, auction AS A, product AS P WHERE T3.auctionId = A.auctionId and A.productId = P.productId";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String product_name = rs.getString("product");
                int maxCount = rs.getInt("count");
                out.println(product_name + " " + maxCount);
            }




            // Best Buyers
            sql = "WITH T1 as (SELECT bidding.auctionId, bidding.bidPrice FROM bidding as bidding where bidding.didWin = 1), T2 as (SELECT T1.auctionId, sum(T1.bidPrice) as price FROM T1 GROUP BY T1.auctionId ORDER BY price DESC) SELECT A.username as username, T2.price as earnings FROM T2, auction as A WHERE T2.auctionId = A.auctionId limit 5";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String username = rs.getString("username");
                int earnings = rs.getInt("earnings");
                out.println(username + " " + earnings);
            }
            

        }catch(Exception e){
 		    out.println(e.getMessage());
 	    }
    %>
</body>
</html>