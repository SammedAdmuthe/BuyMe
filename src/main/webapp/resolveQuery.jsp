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
 	String queryId = request.getParameter("queryid");
 	String answer = request.getParameter("entry"+queryId);
	//out.println(answer+ queryId);
  	DBHelper dbhelper = new DBHelper();
  	Connection connection = dbhelper.getConnection();

 	
  	try{
 		Statement stmt = connection.createStatement();
	
 		PreparedStatement ps1 = connection.prepareStatement("update userqueries set answer=?, queryStatus=? where queryId = ?");
		ps1.setString(1, answer);
		ps1.setString(2, "1");
		ps1.setString(3, queryId);
		ps1.executeUpdate();
		
		response.sendRedirect("customerRepPortal.jsp");
		
  	}catch(Exception e){
  		out.println(e.getMessage());
  	}
 	dbhelper.closeConnection(connection); 
%>