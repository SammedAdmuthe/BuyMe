<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.AddressException" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="java.util.Properties" %>


<%
/* 	DBHelper dbhelper = new DBHelper();
 */
 	String query = request.getParameter("queryField");
 	String username = request.getParameter("usernameForQuery");
	//out.println(query+ username);
  	DBHelper dbhelper = new DBHelper();
  	Connection connection = dbhelper.getConnection();
  	Statement stmt = connection.createStatement();
 	
  	try{
  		int rs1 = stmt.executeUpdate("insert into userqueries (queryStatus, query, answer, username) values (0, '"+query+"', '', '"+username+"');");
		response.sendRedirect("home.jsp");
		
  	}catch(Exception e){
  		out.println(e.getMessage());
  	}
 	dbhelper.closeConnection(connection); 
%>