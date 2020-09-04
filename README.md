# flipper

Flipper consumes and renders a Menu object from the Flipdish API.

The pattern followed is a VIPER style flow, with the aim of improving single responsibility, testability and minimising dependancies between objects.

Integration tests have been included for the MenuPresenter, testing the Menu modules' logic.

NOTE: The SDWebImage was included via Swift Package Manager as an image caching solution.
