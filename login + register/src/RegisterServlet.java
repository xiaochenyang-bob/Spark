

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
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Entered Register Servlet");
		HttpSession session = request.getSession();
		String error ="";
		String next = "/HomePage.jsp";
		String username = request.getParameter("usernameRegister");
		String password = request.getParameter("passwordRegister"); 
		String passwordConfirmation = request.getParameter("confirmPasswordRegister"); 
		String bio = request.getParameter("bioRegister"); 
		String prem  = request.getParameter("premiumUser");

		System.out.println("Username: " + username);
		System.out.println("Password: " + password);
		System.out.println("Password Confirmation:  " + passwordConfirmation);
		System.out.println("Bio: " + bio );
		System.out.println("Are they premium?: " + prem); 
		int accountType = 0; 
		
		if(prem==null) {
			System.out.println("nothing was selected for premium"); 
			error+="That username is already taken by another account.";
			next="/RegisterPage.jsp";	
			request.setAttribute("errorRegister", error);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
	        dispatch.forward(request, response);
		}
		else if(prem.equals("YES") ) {
			System.out.println("This is a premium user"); 
			accountType =1; 
		}
		else {
			System.out.println("Not a Premium user");
		}
		// Validation
		
		
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
				error+="That username is already taken by another account.";
				next="/RegisterPage.jsp";
			}
			else {
				if(password.equals(passwordConfirmation)== false) {
					error+="The passwords do not match.";
					next="/RegisterPage.jsp";
				}
				else {
					System.out.println("Adding a new user");
					queryCheck = "INSERT INTO Users(username, password, account_type) VALUES(?,?, ?)";
					st = conn.createStatement();
					System.out.println(st.executeUpdate("INSERT INTO Users(username, password, account_type) VALUES('"+username + "', '"+password+ "', " + accountType + ")"));
				}
		
			}
			request.setAttribute("errorRegister", error);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
	        dispatch.forward(request, response);
		
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
