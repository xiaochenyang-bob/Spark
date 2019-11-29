<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*, java.io.*, java.sql.*"%>
<%
Connection conn = null;     
PreparedStatement ps= null;      
ResultSet rs= null;
String searchString = "DELETE FROM Matches WHERE from = ? AND to = ?;";
int from_id = Integer.parseInt(request.getParameter("from_id"));
int to_id = Integer.parseInt(request.getParameter("to_id"));
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password");
	ps= conn.prepareStatement(searchString);
	ps.setInt(1, from_id);
	ps.setInt(2, to_id);
	rs = ps.executeQuery();
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
		<title>Delete Confirmation Page</title>
		<link rel="stylesheet"
		 href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
		 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
		 crossorigin="anonymous">
		 <link href="https://fonts.googleapis.com/css?family=Dancing+Script&display=swap" rel="stylesheet">
		 <!-- <link rel="stylesheet" type="text/css" href="style.css"> -->
		 <script src="https://kit.fontawesome.com/4abbf48612.js" crossorigin="anonymous"></script>
		 <style>
		 	body{
			margin: 0;
			padding: 0;
		}
		#user_image{
			text_align: center;
		}
		#user_image img{
			width: 100%;
			height: auto;
			border-radius: 50%;
			border: 1px solid black;
			margin-top: 10%;
		}
		#username {
			text-align: center;
		}
		#username h2{
			margin-top: 50%;
		}
		.clearfloat{
			clear: both;
		}
		#page_title{
			text-align: center;
			margin-top: 7%;
		}
		#buttons{
			margin-top: 7%;
			text-align: center;
		}
		#header{
			background-image: url("pink_background.jpg");
	        background-size: cover;
            background-position: center;
            padding-bottom: 3%;
		}
		#header h1,h2{
			 font-family: 'Dancing Script', cursive;
			 font-weight: bold;
		}
		#message{
			text-align: center;
			font-weight: bold;
			color: green;
			margin-top: 3%;
		}
		#back_button{
			text-align: center;
			margin-top: 3%;
		}
		 </style>
	</head>
	<body>
		<div class = "container-fluid">
			<div class = "row" id = "header">
				<div id = "user_image" class = "col col-lg-2 col-sm-12">
					<%-- <img src = <%= avatar_url %> alt = "user_profile"> --%>
					<img src = "default_avatar.png" alt = "avatar">
					<%-- <p><%= username %></p> --%>
				</div>
				<div id = "username" class = "col col-lg-2 col-sm-12">
					<h2>Username</h2>
				</div>
				<div id = "page_title" class = "col col-lg-4 col-sm-12">
					<h1>Matches</h1>
			    </div>
				<div id = "buttons" class = "col col-lg-4 col-sm-12">
						<button type="button" class="btn btn-primary" id = "discover_button">Discover</button>
						<button type="button" class="btn btn-primary" id = "premium_button">See Who Liked You</button>
					    <button type="button" class="btn btn-primary" id = "signOut_button">Sign Out</button>
				</div>
		    </div>
		    <div class = "row">
		    	<div id = "message" class = "col col-12">
		    		This user is successfully deleted from your matches. 
		    	</div>
		    	<div class = "col" id = "back_button">
		    		<button type = "button" class="btn btn-primary" onclick = "location.href='Matches.jsp'">Back to my matches</button>
		    	</div>
		    </div>
		 </div>
		 <script>
		 document.querySelector("#discover_button").onclick = function(){
				window.location.href = "SwipPage.html?user_id=" + <%= from_id %>;
			}
			document.querySelector("#premium_button").onclick = function(){
				window.location.href = "open_premium.jsp?user_id=" + <%= from_id%>;
			}
			document.querySelector("#signOut_button").onclick = function(){
				window.location.href = "LogOut";
			}
			let user_profiles = document.querySelectorAll(".liked_profiles");
			for (let i = 0; i < user_profiles.length; ++i)
			{
				user_profiles[i].onclick = function(){
					let to_id = this.alt;
					<%-- window.location.href = "chat.jsp?from_user=" + <%= username %> + "to_user=" + to_username; --%>
					window.location.href = "chat?usera=" + <%= from_id %> + "&userb=" + to_id;
				}
			} 
		 </script>
	</body>
</html>