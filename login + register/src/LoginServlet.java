

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Entered Log-in Servlet" ); 
		
		HttpSession session = request.getSession();
		String error ="";
		String next = "/Matches.jsp";
		String username = request.getParameter("usernameLogin");
		String password = request.getParameter("passwordLogin"); 
		int userID = 0; 
		Connection conn = null; 
		Statement st = null; 
		ResultSet rs = null; 
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password");
			String queryCheck = "SELECT * from Users WHERE username = ?";
			PreparedStatement ps = conn.prepareStatement(queryCheck);
			ps.setString(1, username);
			ResultSet resultSet = ps.executeQuery();
			if(resultSet.next()) {
				if(resultSet.getString("password").equals(password) == false) {
					error+="Incorrect Password";
					System.out.println("Incorrect Password was enterred");
					next="/LoginPage.jsp";
					session.setAttribute("error", error);
					System.out.println("error " + session.getAttribute("error"));
					RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
			        dispatch.forward(request, response);
			        return; 
				}
			}
			else {
				error+="This user does not exist.";
				next="/LoginPage.jsp";
				session.setAttribute("error", error);
				RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		        dispatch.forward(request, response);
		        return;
			}
		}
		catch(ClassNotFoundException | SQLException sqle) {
			sqle.printStackTrace();;
		}
		finally {
			try {
				if(rs!= null) {
					rs.close();
				}
				if(st!=null) {
					st.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				sqle.printStackTrace();
			}
		}
	
	}

}
