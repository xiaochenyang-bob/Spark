<%@page import="java.util.*, java.io.*, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Connection conn = null;     
Statement st= null;      
ResultSet rs= null;
String searchString = "SELECT id, username, avatar FROM Users ORDER BY RAND();"; 
ArrayList<String> usernames = new ArrayList<String>();
ArrayList<String> avatars = new ArrayList<String>();
ArrayList<Integer> user_Ids = new ArrayList<Integer>();
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password");
	st = conn.createStatement();
	rs = st.executeQuery(searchString);
	while (rs.next())
	{
		int user_id = rs.getInt("id");
		String username = rs.getString("username");
		String avatar = rs.getString("avatar");
		usernames.add(username);
		avatars.add(avatar);
		user_Ids.add(user_id);
	}
}catch(SQLException sqle){
	System.out.println(sqle.getMessage());
}finally{
	try {
		if (rs != null) {
			rs.close();
		}
		if (st != null) {
			st.close();
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
		<title>Home Page</title>
		<link rel="stylesheet"
		 href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
		 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
		 crossorigin="anonymous">
		 <link href="https://fonts.googleapis.com/css?family=Dancing+Script&display=swap" rel="stylesheet">
		 <link rel="stylesheet" type="text/css" href="style.css">
		 <script src="https://kit.fontawesome.com/4abbf48612.js" crossorigin="anonymous"></script>
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
				<%
				 for (int i = 0; i<usernames.size(); ++i)
				 {
			    %>
			    	<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<!-- where database data comes in -->
					<img src = <%= avatars.get(i) %> alt = <%=user_Ids.get(i) %> class = "user_image">
					<p><%= usernames.get(i) %></p>
					</div>
			    <% 
				 }	 
				%>
				<!-- code for testing the format -->
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "1" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "2" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "3" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "4" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "5" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "6" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "7" class = "user_image">
					<p>User</p>
				</div>
				<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
				<!-- where database data comes in -->
					<img src = "default_avatar.png" alt = "8" class = "user_image">
					<p>User</p>
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
			let user_images = document.querySelectorAll(".user_image");
			for (let i = 0; i<user_images.length; i++)
			{
				user_images[i].onclick = function() {
					let user_id = this.alt;
					window.location.href = "user_detail.jsp?user_id=" + user_id;
				}
			}
		</script>
	</body>
</html>