<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method = "post" action = "login.jsp">
		<p>
	     <label>Username: <input type="text" id="username" name = "username" required
	      placeholder="Username must be at least 8 characters long
	      and include only letters or numbers" /></label>
	    </p>
	    <p>
	     <label>Password: <input type="password" id="pwd" name = "pwd" required
	       placeholder="Password must be at least 8 characters long
	      and include numbers and punctuation characters" /></label>
	    </p>
	    
	    <input type="submit" id="registerSubmit" value="Create Account"/>	
	</form>
    
</body>
</html>