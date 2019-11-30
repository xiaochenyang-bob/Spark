<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*, java.io.*, java.sql.*"%>
<%
int user_id =Integer.parseInt(request.getParameter("user_id"));
	Connection conn = null;     
	PreparedStatement ps= null;      
	ResultSet rs= null;
	String searchString = "SELECT Account_type FROM Users WHERE id = ?;";
	try{
		//Not sure why suddenly stop working
		Class.forName("com.mysql.jdbc.Driver");
		//to do
		conn = DriverManager.getConnection("jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password");
		ps= conn.prepareStatement(searchString);
		ps.setInt(1, user_id);
		rs = ps.executeQuery();
		rs.next();
		int user_type = rs.getInt("Account_type");
		if (user_type == 1)
		{
			response.sendRedirect("premium.jsp?user_id=" + user_id);
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
	<title>Open Premium</title>
	<link rel="stylesheet"
		 href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
		 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
		 crossorigin="anonymous">
</head>
<body>
	<h2>Do you want to become a PREMIUM user?</h2>
	<button type="button" class="btn btn-success" onclick = "location.herf = 'premium.jsp?user_id=' + <%= user_id %>">Yes</button>
	<button type="button" class="btn btn-danger" onclick = "location.herf = 'Matches.jsp'" >Nope</button>
</body>
</html>