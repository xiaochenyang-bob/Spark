

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;


import com.google.gson.Gson;

@WebServlet("/chat")
public class MessagingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String chatServerUrl = "localhost:3000";
	private final CloseableHttpClient httpClient = HttpClients.createDefault();
	MessagingDBManager db;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessagingServlet() {
        super();
        // TODO Auto-generated constructor stub
        db = new MessagingDBManager();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//int usera_id = Integer.parseInt(req.getParameter("usera"));
		int userb_id = Integer.parseInt(req.getParameter("userb")) + 1;
		String usera_name = db.getLatestUsername();
		int usera_id = db.getLatestUserId();
		//String usera_name = db.getUsernameById(usera_id);
		String userb_name = db.getUsernameById(userb_id);
		createUserInChatkit(usera_name);
		createUserInChatkit(userb_name);
		System.out.println(usera_name + " and " + userb_name);

		
		String room_id = db.hasDialogue(usera_id, userb_id);
		//Send 1 http request to create room	
		if(room_id==null) {
			db.createDialogue(usera_id, userb_id, usera_name, userb_name);
			room_id = createNewRoom(usera_name, userb_name);
			//Check whether there's a dialogue, no? create one
		}
		System.out.println("Redirect to: " + "http://localhost:3000/" + usera_name + "/" + userb_name + "/"  +room_id);
		res.sendRedirect("http://localhost:3000/" + usera_name + "/" + userb_name + "/"  +room_id);
	}

	private String createNewRoom(String usera_name, String userb_name) {
		// TODO Auto-generated method stub
		HttpGet request = new HttpGet("http://localhost:3001/newroom/" + usera_name + "/" + userb_name);
		try (CloseableHttpResponse response = httpClient.execute(request)) {
		    // GetHttpResponse Status
		    System.out.println(response.getStatusLine().toString());
		    HttpEntity entity = response.getEntity();
		    Header headers = entity.getContentType();
		    System.out.println(headers);
		    if (entity != null) {
		        // return it as a String
		        String result = EntityUtils.toString(entity);
		        System.out.println(result);
		    }
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return usera_name + "&" + userb_name;
	}

	private void createUserInChatkit(String usera_name) {
		// TODO Auto-generated method stub
		HttpGet request = new HttpGet("http://localhost:3001/users/" + usera_name);
		try (CloseableHttpResponse response = httpClient.execute(request)) {
		    // GetHttpResponse Status
		    System.out.println(response.getStatusLine().toString());
		    HttpEntity entity = response.getEntity();
		    Header headers = entity.getContentType();
		    System.out.println(headers);
		    if (entity != null) {
		        // return it as a String
		        String result = EntityUtils.toString(entity);
		        System.out.println(result);
		    }
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	}
	
	public static void main(String[] args) {
		MessagingServlet s = new MessagingServlet();
		s.createNewRoom("abc", "bbb");
	}
 
}
