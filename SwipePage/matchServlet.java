import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class matchServlet
 */
@WebServlet("/matchServlet")
public class matchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public matchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		establishConnection();
		
		// FIXME: The SQL Query
		
		// Redirect to Matches.jsp
		response.sendRedirect(request.getContextPath() + "/Matches.jsp");
	}

	void establishConnection() {
		String url = "jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password";
		try {
			conn = DriverManager.getConnection(url);
			st = conn.createStatement();
		} catch (SQLException sqle) {
			System.out.println("SQLException:" + sqle.getMessage());
		}
	}

}
