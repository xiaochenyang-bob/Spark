/// Contains the information for each user, displayed on the swipable cards.
class User {
	constructor(username, gender, description, imageName) {
		this.username = username;
		this.gender = gender;
		this.description = description;
		this.imageName = imageName;
	}
}

/* 
 Fetches the User to display.
 - Returns: Array of User.
 */
function fetchUsers() {
	// TODO: This is incomplete.

	let user1 = new User("Bob",  "male", "The Best Player.", "2.jpg");
	let user2 = new User("Josh",  "male", "Unbelievably good.", "3.jpg");
	let user3 = new User("Johnny", "male","Best in the world.", "4.jpg");
	let user4 = new User("Kevin",  "male", "How's that?", "5.jpg");
	let user5 = new User("Selina", "female", "2nd best in the world.", "6.jpg");
	let user6 = new User("Kate", "female", "Who else can be better?", "7.jpg");
	let user7 = new User("Trina", "female", "This is defintely the best person.", "8.jpg");
	let user8 = new User("Jony", "male", "The great designer.", "9.jpg");
	let user9 = new User("Tim", "male", "The money maker of all time.", "10.jpg");

	let allUsers = [user1, user2, user3, user4, user5, user6, user7, user8, user9];

	return allUsers;

	// Uncomment the following code to enable network requests
	/*
	$.ajax({url: "THE_URL_WE_NEED_TO_MAKE_THE_NETWORK_REQUEST", 
		success: function(result) {
			let remainingUsers = users.slice(0, 4);

			// Uncommment the following code if result is string, otherwise easy.
			// let newUsers = JSON.parse(result);

    		User.allUsers = remainingUsers.concat(newUsers);
    		User.currentUserIndex = 0;
  	    }
    });
    */
    
}

/// Prepares the card.
function updateUI() {
	let cardIDs = ["frontCard", "middleCard", "backCard"];
	let cards = [];
	for (let i = 0; i < cardIDs.length; i++) {
		cards.push(document.getElementById(cardIDs[i]));
	}

	// Reset the styling of each card
	for (let i = 0; i < cards.length; i++) {
		cards[i].style.transition = "0.5s all ease-in-out";
		cards[i].style.opacity = 1;
		cards[i].style.transform = "translateY(-" + i*20 + "px)";
		cards[i].style.zIndex = 2-i;
	}

	// Get the three users to display
	let currentUsers = [];
	for (let i = 0; i < cardIDs.length; i++) {
		currentUsers.push(User.allUsers[(User.currentUserIndex + i) % User.allUsers.length]);
	}

	// Modify the card contents according to the three users
	for (let i = 0; i < cards.length; i++) {
		displayUserOnCard(cards[i], currentUsers[i]);
	}
}

/* 
 Updates the card with the given user's information.
 - Parameter card: the card to update.
 - Paramter user: the user whose information will be displayed on the given card.
 */
function displayUserOnCard(card, user) {
	card.getElementsByClassName("nameLabel")[0].innerHTML = user.username;
	card.getElementsByClassName("friendImage")[0].src = user.imageName;
	card.getElementsByClassName("genderSymbol")[0].src = (user.gender === "male" ? "male.png" : "female.png");
	card.getElementsByClassName("descriptionLabel")[0].innerHTML = user.description;
}

/* Called when a swipableCard button is clicked.
 * - Parameter id: the id of the button being clicked.
 */
function buttonClicked(id) {

	// Increment the current user index
	User.currentUserIndex += 1;
	/// Fetch new users if we are reaching the end
	if (User.currentUserIndex === User.allUsers.length - 3) {
		fetchUsers();
	}

	// FIXME: Hardcode. Adds new match after 0.1 seconds
	if (User.currentUserIndex === 3) {
		setTimeout(function() {
			document.getElementById("notificationButton").style.display = "inline-block";
		}, 100);
	}

	// Animates the front card
	let button = document.getElementById(id);
	switch (id) {
	case "dislikeButton":
		animateFrontCard("left");
		break;
	case "likeButton":
		animateFrontCard("right");
		break;
	}
}

/* Animates the front card.
 * - Parameter direction: The direction of the swipe.
 */
function animateFrontCard(direction) {
	let card = document.getElementById("frontCard");
	let translation = "200px";
	let rotation = "20deg";
	switch (direction) {
	case "left":
		translation = "-700px";
		rotation = "-30deg";
		break;
	case "right":
		translation = "700px";
		rotation = "30deg";
		break;
	}
	card.style.transform = "translateX(" + translation + ") rotate("+ rotation + ")";
	
	// Change the opacity after 0.09s and restore cards after 0.5s
	setTimeout(function() { 
		card.style.opacity = 0;
		setTimeout(function() {
			restoreCards();
		}, 500);
		
	}, 90);
}

/// Restores the card back to original state after swipe is complete.
function restoreCards() {
	let frontCard = document.getElementById("frontCard");
	let middleCard = document.getElementById("middleCard");
	let backCard = document.getElementById("backCard");

	// Insert front card to the back, change opacity back to 1
	frontCard.style.transition = "0s all";
	frontCard.style.zIndex = "0";
	frontCard.style.transform = "translateY(-180px)";
	frontCard.style.opacity = 0;

	setTimeout(function() {
		// Change the id of frontCard, middleCard, and backCard.
		frontCard.id = "temp";
		middleCard.id = "frontCard";
		backCard.id = "middleCard";
		frontCard.id = "backCard";
		frontCard = document.getElementById("frontCard");
		middleCard = document.getElementById("middleCard");
		backCard = document.getElementById("backCard");

		let cards = [frontCard, middleCard, backCard];

		updateUI();
	}, 50);
}

/// Called after the document is loaded. Do all the preparation work in this method.
function prepareUI() {
	User.currentUserIndex = 0;
	User.allUsers = fetchUsers();
	updateUI();
}

prepareUI();


