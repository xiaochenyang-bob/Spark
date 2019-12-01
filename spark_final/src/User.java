

public class User {
	private String username;
	private String roomid;

	public User(String username, String roomid) {
		super();
		this.username = username;
		this.roomid = roomid;
	}

	public String getUsername() {
		return username;
	}

	public String getRoomid() {
		return roomid;
	}

	public void setRoomid(String roomid) {
		this.roomid = roomid;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
