<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*, java.io.*, java.sql.*"%>
<!-- Connect to the database and get info for the matched users -->
<%
	Connection conn = null;     
	PreparedStatement ps1= null;
	PreparedStatement ps2 = null;
	ResultSet rs1= null;
	ResultSet rs2 = null;
	String searchString = "SELECT Users.username AS username, Users.avatar AS avatar FROM Matches" +
			" JOIN Users ON Users.id = Matches.to WHERE from = ? ORDER BY match_date DESC;";
	String findAvatarLink = "SELECT username, avatar FROM Users WHERE id = ? ;";
	ArrayList<String> usernames = new ArrayList<String>();
	ArrayList<String> avatars = new ArrayList<String>();
	String avatar_url = "";
	String username = "";
	int from_id = 0;
	if (request.getParameter("user_Id") != null)
	{
		from_id = Integer.parseInt(request.getParameter("user_Id"));
	}

	try{
		//not sure why not working
		//Class.forName("com.mysql.jdbc.Driver");
		//to do
		conn = DriverManager.getConnection("link to database");
		ps1= conn.prepareStatement(searchString);
		ps2 = conn.prepareStatement(findAvatarLink);
		ps1.setInt(1, from_id);
		ps2.setInt(1, from_id);
		rs1 = ps1.executeQuery();
		rs2 = ps2.executeQuery();
		while (rs1.next())
		{
			usernames.add(rs1.getString("username"));
			avatars.add(rs1.getString("avatar"));
		}
		if (rs2.next())
		{
			avatar_url = rs2.getString("avatar");
			username = rs2.getString("username");
		}
	}catch(SQLException sqle){
		System.out.println(sqle.getMessage());
	}finally{
		try {
			if (rs1 != null) {
				rs1.close();
			}
			if (ps1 != null) {
				ps1.close();
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
		.user_avatar img{
	        width: 100%;
	        height: auto;
	        cursor: pointer;
        }
        .user_avatar{
	        text-align: center;
	        font-size: 2em;
	        padding-left: 5%;
	        padding-right: 5%;
        }
        .user_avatar p{
        	font-family: 'Dancing Script', cursive;
        	margin-bottom: 0;
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
		    <div class = "row" id = "users">
		    <%
		    for (int i = 0; i<usernames.size(); ++i)
		    {
		    %>
		    	<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "<%= avatars.get(i) %>" alt = "<%= i %>" class = "liked_profiles">
					<p><%= usernames.get(i) %></p>
					 <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + '<%= usernames.get(i) %>'" >Unlike</button>
				</div>
		    <%
		    }
		    %>
		    <!-- Code for testing, delete them when database is built -->
		    <div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1"  class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" id = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			<div class = "col col-lg-3 col-md-4 col-sm-6 user_avatar">
					<img src = "default_avatar.png" alt = "1" class = "liked_profiles">
					<p>Liked User</p>
				    <button type="button" class="btn btn-danger" class = "unlike_button" onclick = "location.href = 'delete_confirmation.jsp?/username=' + 'likedUser'">Unlike</button>
			</div>
			
			</div>				
	</div>
	<script>
	document.querySelector("#discover_button").onclick = function(){
		window.location.href = "SwipPage.jsp";
	}
	document.querySelector("#premium_button").onclick = function(){
		window.location.href = "open_premium.jsp?user_id=" + <%= from_id%>;
	}
	document.querySelector("#signOut_button").onclick = function(){
		window.location.href = "LogOut";
	}
	let user_profiles = document.querySelectorAll(".liked_profiles");
	console.log(document.querySelector(".liked_profiles").nextElementSibling.innerHTML);
	for (let i = 0; i < user_profiles.length; ++i)
	{
		user_profiles[i].onclick = function(){
			let to_username = this.nextElementSibling.innerHTML;
			<%-- window.location.href = "chat.jsp?from_user=" + <%= username %> + "to_user=" + to_username; --%>
			window.location.href = "chat.jsp?from_user=Username&to_user=" + to_username;
		}
	} 
    </script>
</body>
</html>