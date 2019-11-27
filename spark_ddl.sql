
CREATE TABLE Users ( 
	id int(11) PRIMARY KEY not null AUTO_INCREMENT, 
	username VARCHAR(255) not null,
	password VARCHAR(255) not null,
	Account_type int(11) not null,
	created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Likes (
	id int(11) PRIMARY KEY not null AUTO_INCREMENT, 
	f int(11) not null,
	t int(11) not null,
	FOREIGN KEY (f) REFERENCES Users(id),
	FOREIGN KEY (t) REFERENCES Users(id)
);

CREATE TABLE Matches (
	id int(11) PRIMARY KEY not null AUTO_INCREMENT, 
	f int(11) not null,
	t int(11) not null,
	match_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (f) REFERENCES Users(id),
	FOREIGN KEY (t) REFERENCES Users(id)
);

CREATE TABLE Dialogues (
	id int(11) PRIMARY KEY not null AUTO_INCREMENT, 
	user_a int(11) not null,
	user_b int(11) not null,
	room_id varchar(255) not null unique,
	start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_a) REFERENCES Users(id),
	FOREIGN KEY (user_b) REFERENCES Users(id)
);




