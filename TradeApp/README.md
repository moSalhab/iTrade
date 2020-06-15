
# iTrade

This App uses Alamofire API.

## Overview

This App let users to upload items and let them trade with other users witht their items whithout use any kind of money.


## Usage

Login page, this login let user to enter the username and passwork to login to the main page.
Register page, this page let new user to register in the app by inserting the user information.
Forget password, this page let user to retreive their old password by inserting the username

My item page, this page let user to show the user's items that has been uploaded, in the right botton in the navigation bar (+), opens the add item page, if I choose an items, I can see the details of the items selected

Add item page, let user to add new item and the adding is in new steps:
1. adding item's info
2. press add item button
3. add images from the gallary for the item with the right button in the navigation controller.

All items in the tab bar Controller
All items page, this page will show all items that has been uploaded, and if I choose an item sI can see the details of the item, I can propose a trade with the item by pressing Trade button

If I pressed Trade button a table of my items will be shown, and I can choose from my items to be involved in the trade process.

Offers in the tab bar controller,
in this page will show you the send offers and received offers.
In sent Offers page it shows the offer been sent to other user, if I choose an offer, the offer details will be shown in new page and if the offer is accepted I press show user info button to see contact name of the recever and the meeting point

Recieved offer page will show the received offers from other users and when choose an offer the user can see the details of the offer the requested item and the offered item, and the user can accept or reject the offer.

## API
In this application I used private API, with Alamofire library.

## Data persistence
In this application I persisted the user data infromation, in which the user can open the app without logging in each time.



