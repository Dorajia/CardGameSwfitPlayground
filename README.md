# CardGameSwfitPlayground
Swift Playground Project Description
In this project, I developed a simple game called “Rule out Joker” in swift playground for iOS platform, the idea is inspired from a poker game called “Joker” and match pairs memory cards game. 

In this game, there are nine playing cards, including 4 pairs of same cards and one joker poker card. At first, players only can see the back side of the playing cards. Then they can choose to flip two cards at a time. If those two cards are not same, they will flip over to back again and players need to choose another cards; If they are the same card, those two cards will disappear from card set. In the end, players need to find all the pairs and the Joker will be the only card left. The positions of the playing cards are not fixed every time the game runs. 

There are several technologies applied to this project:
The UIKit framework is used to construct the user interface of the application. 
1.	UIStackView is used to arrange the playing cards as grid view. The cards are arranged as three rows by three columns.
2.	UIView’s transition animation - UIViewAnimationOptions.transitionFlipFromRight and transitionFlipFromLeft is used to animate the flipping of cards. 
3.	UIView’s animation - UIViewAnimationOptions.curveEaseOut is used to animate the disappearing of the cards. 
4.	UIImageView is used as container of the cards.
5.	UITapGestureRecognizer is used to make interaction with players. 

In the responder class of tap, the application will judge whether the two flipped cards are same or not, and then react correspondingly. All the UIImageViews are put into one array. Every time the game runs, the array will be shuffled randomly to make sure the positions of the cards are not fixed. Tags are used to tag the cards as flipped or not and accessibilityIdentifier are used to match the same cards. 
