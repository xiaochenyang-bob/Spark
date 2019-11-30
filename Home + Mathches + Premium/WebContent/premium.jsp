<%@page import="java.util.*, java.io.*, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
int user_id =Integer.parseInt(request.getParameter("user_id"));
	Connection conn = null;     
	PreparedStatement ps= null;      
	ResultSet rs= null;
	String updateString = "UPDATE Users SET Account_type = 1 WHERE id = ?";
	/* String findLikes = "SELECT " */
	try{
		//Not sure why suddenly stop working
		//Class.forName("com.mysql.jdbc.Driver");
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
<header>
</header>
<body>
	<div id = "header"> <div>
</body>
</html>
