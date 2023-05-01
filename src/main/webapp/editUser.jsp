<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
</head>
<body>

	<%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		try{
			Statement stmt = connection.createStatement();
			String usr = request.getParameter("username");
			ResultSet rs = stmt.executeQuery("Select * from enduser where username ='"+usr+"'");
			rs.next();
	%>
	<div style="height: 100%; width: 100%; background-image: linear-gradient(to right,#0099ff, #e6f5ff);
    display: flex; justify-content: center;">
        <form method="post" action="updateUser.jsp" style="height: 400px; width: 300px; padding: 10px;
        background-color: #e6f5ff; margin-top: 10%; border-style: groove; border-color: #b3e0ff">
            <label for="fname">First Name:</label><br>
            <input type="text" id="fname" name="fname" value = "<%=rs.getString("firstName")%>" required><br>
            <label for="lname">Last Name:</label><br>
            <input type="text" id="lname" name="lname" value = "<%=rs.getString("lastName")%>" required><br>
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" value = "<%=rs.getString("username")%>" required><br>
            <label for="address">Address:</label><br>
            <input type="text" id="address" name="address" value = "<%=rs.getString("address")%>" required><br>
            <label for="phone">Phone Number:</label><br>
            <input type="text" id="phone" name="phone" value = "<%=rs.getString("phoneNo")%>" required><br>
            <label for="dob">Date of Birth:</label><br>
            <input type="date" id="dob" name="dob" value = "<%=rs.getString("dob")%>" required><br>
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" value = "<%=rs.getString("emailId")%>" required><br>
            <br>
            <label for="cpwd">Secret Key:</label><br>
            <input type="password" id="sid" name="sid"><br>
            <input type="submit" value="Update">
        </form>
    </div>
    <%
		}
		catch(Exception e){
	 		out.println(e.getMessage());

		}
	%>

    

</body>
</html>