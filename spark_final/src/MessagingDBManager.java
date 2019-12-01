

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;;

public class MessagingDBManager {
	
	
	private static final String CREDENTIALS_STRING = "jdbc:mysql://google/Spark?cloudSqlInstance=cs201-lab7:us-central1:cs201-spark&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=SparkUser&password=password";
	Connection conn = null;
	
	public MessagingDBManager() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(CREDENTIALS_STRING);
		} catch (SQLException e) {
			System.out.println("Error connecting to database!");
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println("Class Not Found");
		}
	}
	
	
	/**
	 * If there's already a chatroom for userA and userB, return the room ID, otherwise return null
	 * Should check both A to B and B to A
	 * @param usera_id user_id of user A
	 * @param userb_id user_id of user B
	 * @return
	 */
	public String hasDialogue(int usera_id, int userb_id) {
		String room_id = null;
		try {
			PreparedStatement st = conn.prepareStatement("select room_id from Dialogues where (user_a=? and user_b=?) or(user_a=? and user_b=?)");
			st.setInt(1, usera_id);
			st.setInt(2, userb_id);
			st.setInt(3, userb_id);
			st.setInt(4, usera_id);
			ResultSet res = st.executeQuery();
			if(res.first()) room_id = res.getString("room_id");
			else return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return room_id;
	}
	
	/**
	 * Get the username of a user by its unique user id
	 * @param userid
	 * @return
	 */
	public String getUsernameById(int userid) {
		
		try {
			PreparedStatement st = conn.prepareStatement("select username from Users where id=?");
			st.setInt(1, userid);
			ResultSet res = st.executeQuery();
			res.first();
			return res.getString("username");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error while trying to retrive username by id " + userid);
		}
		return null;
	}


	public void createDialogue(int usera_id, int userb_id, String usera_name, String userb_name) {
		// TODO Auto-generated method stub
		String room_id = usera_name + "&" + userb_name;
		try {
			PreparedStatement st = conn.prepareStatement("insert into Dialogues(user_a, user_b, room_id) values(?,?,?)");
			st.setInt(1, usera_id);
			st.setInt(2, userb_id);
			st.setString(3, room_id);
			st.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}


	public String getLatestUsername() {
		try {
			PreparedStatement st = conn.prepareStatement("select username from Users order by id desc");
			ResultSet res = st.executeQuery();
			res.first();
			return res.getString("username");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error while trying to retrive username by id ");
		}
		return null;
	}


	public int getLatestUserId() {
		try {
			PreparedStatement st = conn.prepareStatement("select id from Users order by id desc");
			ResultSet res = st.executeQuery();
			res.first();
			return res.getInt("id");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error while trying to retrive username by id ");
		}
		return 0;
	}
}
