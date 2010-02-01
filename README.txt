
DATA LOGGER FOR IPHONE V.0.27

___________________________________

Data Logger for iPhone enables you to store and graph any data of your choosing along with a timestamp and geolocation. You might use Data Logger to store electricity meter readings, to create maps of pollution or temperature sensor readings around your neighbourhood, or animal sightings around the city. You can also set up custom data feeds, with user-defined min and max values, tags, description and units. 
___________________________________


TODO:

- Create a connection class that handles all the connections. Currently each viewController has it's own connection method - this should be generic.

 - Move to CoreData as the data storage mechanism. Currently all feeds are stored as UserDefaults.


KNOWN ISSUES:

- If a feed does not contain any tags it will not update the connection can sometimes break.

- Adding text into the username/password fields in the settings page and the url/location fields of the feed metadata page require the user to press done. The app should recognise moving on to the next field as a finished edit and save the input.

- Occasional crashes on page switches, probably due to attempting to referencing an object that no longer exists. 



