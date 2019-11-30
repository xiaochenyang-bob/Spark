<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="SparkStyleSheet.css">
<link rel="stylesheet"
		 href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
		 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
		 crossorigin="anonymous">
		 <link href="https://fonts.googleapis.com/css?family=Dancing+Script&display=swap" rel="stylesheet">
		 <link rel="stylesheet" type="text/css" href="style.css">
		 <script src="https://kit.fontawesome.com/4abbf48612.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Spark Register</title>
</head>
<body>
<div class = "container-fluid">
			<div class = "row">
				<div id = "header" class = "col col-12">
					<a href = "HomePage.jsp">
						<img src = "spark_logo1.png" alt = "spark_logo">
					</a>
					<%
					  if (session.getAttribute("user_id") == null)
					  {
					%>
					<div id = "buttons">
						<a href="./RegisterPage.jsp"><button type="button" class="btn btn-primary" id = "register_button">Register </button></a>
						<a href="./LoginPage.jsp"><button type="button" class="btn btn-primary" id = "login_button">Login</button></a>
					</div>
					<%
					  }
						else
						{
							response.sendRedirect("SwipePage.jsp");
						}
					%>
					<div class = "clearfloat"></div>
				</div>
			</div>
		</div>

<form method="GET" action ="RegisterServlet">
	<br>	
	<br>
	<div style="padding-left:100px; padding-right:100px;">
		<div>
			<p style="color:red"><%=request.getAttribute("errorRegister")!=null ? request.getAttribute("errorRegister"):"" %> </p>
		</div>
		<br>
		<br>
		<p>Username</p>	
		<input style="width:100%; height:30px; font-size: 20px; border: 2px solid black; border-radius: 4px;" type="text" name="usernameRegister"> <br>
		<br>
		<p>Password</p>
		<input style="width:100%; height:30px; font-size: 20px; border: 2px solid black; border-radius: 4px;" type="text" name="passwordRegister"> <br>
		<br>
		<p>Confirm Password</p>
		<input style="width:100%; height:30px; font-size: 20px; border: 2px solid black; border-radius: 4px;" type="text" name="confirmPasswordRegister"> <br>
		<br>
		<p>Short Bio</p>
		<input style="width:100%; height:30px; font-size: 20px; border: 2px solid black; border-radius: 4px;" type="text" name="bioRegister"><br>
		<br>
		<p>Upload an image</p>
		<input type="file" name="pic" accept="image/*">
		<br>
		<br>
		<p>Would you like to be a premium user?</p>
		<input  type="radio" name="premiumUser" value="YES"> Yes
		<input  type="radio" name="premiumUser" value="NO"> No
		<br>
		<br><input style="width:100%; color: white; background: gray; height:35px; font-size:20px" type="submit" value="Register">
	</div>
</form>
</body>
</html>