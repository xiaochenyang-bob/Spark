/* Called when a swipableCard button is clicked.
 * - Parameter id: the id of the button being clicked.
 */
function buttonClicked(id) {

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

		for (let i = 0; i < cards.length; i++) {
			cards[i].style.transition = "0.5s all ease-in-out";
			cards[i].style.opacity = 1;
			cards[i].style.transform = "translateY(-" + i*20 + "px)";
			cards[i].style.zIndex = 2-i;
		}
	}, 50);
}
