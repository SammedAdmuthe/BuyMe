<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up(Staff)</title>
</head>
<body style="height: 100vh; width: 100vw; margin: 0px;">

    <!-- // Take input of First name, last name, username, address, phone no and date of birth
    // Redirect to login page -->
    <div style="height: 100%; width: 100%; background-image: linear-gradient(to right,#0099ff, #e6f5ff);
    display: flex; justify-content: center;">

        <%-- A back arrow to go back to admin.jsp --%>
        <form method="post" action="staffSignUpController.jsp" style="height: 270px; width: 300px; padding: 10px;
        background-color: #e6f5ff; margin-top: 10%; border-style: groove; border-color: #b3e0ff">

            <div style="position: absolute; top: 10px; left: 10px;">
                <a href="admin.jsp" style="text-decoration: none; color: black; font-size: 20px; cursor: pointer;">&#8592;
                    <label style="cursor: pointer;">Back to Admin</label>
                </a>
            </div>
            
            <label for="fname">First Name:</label><br>
            <input type="text" id="fname" name="fname" required><br>
            
            <label for="lname">Last Name:</label><br>
            <input type="text" id="lname" name="lname" required><br>
            
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" required><br>
            
            <label for="pwd">Password:</label><br>
            <input type="password" id="pwd" name="pwd" required><br>
            
            <label for="cpwd">Confirm Password:</label><br>
            <input type="password" id="cpwd" name="cpwd" required><br>

            <br>

            <input type="submit" value="Submit">

            <% 
                if(session.getAttribute("errorMessage") != null){
                    out.println("<p style='color: red'>" + session.getAttribute("errorMessage") + "</p>");
                }
            %>

        </form>
    </div>
	
</body>
</html>