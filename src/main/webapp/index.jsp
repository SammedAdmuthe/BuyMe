<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe!</title>
</head>
<body style="height: 100vh !important; width: 100vw !important; margin: 0px;">
<div style=" height:100%; display: flex; justify-content: center; align-items: center;
			background-image: linear-gradient(to right, #0099ff , #e6f5ff);">
	<form method = "post" action = "login.jsp" style="height: 300px; width: 300px; background-color: #e6f5ff;
	 margin-top: 5%; padding: 10px; border-style: groove; border-color: #05a100;">
			
			<div style="display: flex;">
				<h1 style="color: #007acc; margin-left: 28%">Buy</h1>
				<h1 style="color: #00cc99">Me</h1>
				<h1 style="color: #007acc">!</h1>
			</div>
			
			<div>
				<label style="font-weight: 600">Username:</label>&nbsp;<br>
				<input type="text" id="username" name = "username" required
			      placeholder="Username must be at least 8 characters long
			      and include only letters or numbers" style="width: 98%"/>
			</div><br>
		      
		    <div>
			    <label style="font-weight: 600">Password: </label>&nbsp;<br>
			    <input type="password" id="pwd" name = "pwd" required
			       placeholder="Password must be at least 8 characters long
			      and include numbers and punctuation characters" style="width: 98%"/>
		    </div><br>
		 	<div style="text-align:center;">
		 		<input type="submit" id="registerSubmit" value="Create Account" />	
		 	</div>
		    
		</form>
</div>
	
    
</body>
</html>