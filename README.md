# Felipe Nunez Challenge
This is a repository that contains the weather forecast challenge.

### Requirements
* Build a native iOS app.
* Use the OpenWeatherMap  [5 day weather forecast API](http://openweathermap.org/forecast5) to retrieve the current 5 day weather forecast.
* Give some thought to what will make a decent user experience. We would like to see something readable but with no need to go all out on sleek and flashy UI elements.
* Use any supporting technologies, package management, build systems, component libraries that you are familiar with and feel are appropriate.
* Provide a readme.md file that:
    * Documents how to run / build / test your creation.
    * Documents anything you might implement with more time (features, fixes, technical debt corrections etc).
* The solution should be able to run locally with the appropriate simulator.
* Submit your code into a public git repository of your choice (github / bitbucket etc).

### Build/Run instructions
* Clone or download the contents of this repository.
* Make sure you have at least XCode 9 installer.
* Install cocoapods running the command in terminal:
```
gem install cocoapods
```
* Open the project folder in terminal and run the install command:
```
pod install
```
* Open the UBSChallenge.xcworkspace file using XCode.
* Buid and run the project using any iPhone Simulator.

### Things to implement with more time
* Offer a better experience about each item either showing a detail screen with more information or expanding the cells when the user taps on it.
* Give the user a search option, allowing to search by city name.
* Give the user the option to choose if he want the temperature in C, F or K.
* Show proper error messages to the user to let him know that something went wrong either with the location or the Network request.
* Add the ability to expand or collapse one particular day.
* Rethink the layout to make it more compact about the future days and focus on the current weather.
