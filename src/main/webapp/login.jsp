<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%
/* 	DBHelper dbhelper = new DBHelper();
 */
 	String username = request.getParameter("username");
	String password	= request.getParameter("pwd");
	if(username == null || password == null)
	{	
		//request.setAttribute("errorMessage", null);

		response.sendRedirect("index.jsp");

	}
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	String firstName = "";
 	
 	try{
		Statement stmt = connection.createStatement();
		ResultSet rs = stmt.executeQuery("select * from enduser where username = " + "'"+username+"'"+" and password = "+ "'"+ passwordEncrypter.encrypt(password) +"'");
	
		System.out.println(rs.first());
	 	if(rs.first()) {
	 		firstName = rs.getString("firstName");
			session.setAttribute("username",username);
			//String sessionUser = (String)session.getAttribute("username");
			//out.println("Login Success, hello " + sessionUser);
			session.setAttribute("errorMessage", null);
			response.sendRedirect("home.jsp");
		}
		else
		{
			session.setAttribute("errorMessage", "Invalid username or password");
	        //response.sendRedirect("index.jsp");
			//request.getRequestDispatcher("index.jsp").forward(request, response);
			response.sendRedirect("index.jsp");
			//request.setAttribute("errorMessage", null);
			//response.sendRedirect("index.jsp");
		}
 	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	dbhelper.closeConnection(connection);
%>

