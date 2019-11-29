<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	Connection conn = null;     
	PreparedStatement ps= null;      
	ResultSet rs= null;
	String searchString = "SELECT username, avatar FROM Users WHERE id = ? ;";
	String avatar_url = "";
	String username = "";
	int user_id = Integer.parseInt(request.getParameter("user_Id"));
	try{
		//Not sure why suddenly stop working
		Class.forName("com.mysql.jdbc.Driver");
		//to do
		conn = DriverManager.getConnection("jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password");
		ps= conn.prepareStatement(searchString);
		ps.setInt(1, user_id);
		rs = ps.executeQuery();
		if (rs.next())
		{
			avatar_url = rs.getString("avatar");
			username = rs.getString("username");
		}
	}catch(SQLException sqle){
		System.out.println(sqle.getMessage());
	}finally{
		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>User Detail</title>
	<link rel="stylesheet"
		 href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
		 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
		 crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Dancing+Script&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="style.css">
	<style>
		.decision_button{
			width: 80%;
			margin-left: auto;
			margin-right: auto;
			margin-top: 5%;
		}
		#content{
			text-align: center;
		}
		#content h2{
			margin-top: 5%;
			font-family: 'Dancing Script', cursive;
		}
		#user_image{
			text-align: center;
		}
	</style>
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
						<button type="button" class="btn btn-primary" id = "register_button">Register</button>
						<button type="button" class="btn btn-primary" id = "login_button">Login</button>
					</div>
					<%
					  }
						else
						{
							response.sendRedirect("SwipePage.html?user_id=" + session.getAttribute("user_id"));
						}
					%>
					<div class = "clearfloat"></div>
				</div>
				<div class = "col col-lg-6 col-sm-12" id = "user_image">
					<!-- real code is commented out for testing -->
					<%-- <img src = "<%= avatar_url %>" alt = "userimage"> --%>
					<img src = "default_avatar.png" alt = "userimage">
				</div>
				<div class = "col col-lg-6 col-sm-12" id = "content">
					<%-- <h2><%= username %></h2> --%>
					<h2>Username</h2>
					<button type="button" class="btn btn-success decision_button" id = "like_button">Like</button>
					<button type="button" class="btn btn-danger decision_button" id = "nope_button">Nope</button>
				</div>
			</div>
	 </div>
	<script>
	document.querySelector("#register_button").onclick = function(){
		window.location.href = "register.jsp";
	}
	document.querySelector("#login_button").onclick = function() {
		window.location.href = "login.jsp";
	}
	document.querySelector("#like_button").onclick = function() {
		window.location.href = "register.jsp?newlike=" + <%= user_id %>;
	}
	document.querySelector("#nope_button").onclick = function() {
		window.location.href = "register.jsp";
	}
	</script>
</body>
</html>