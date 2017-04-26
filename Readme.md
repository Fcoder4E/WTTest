/**
Readme file

Author: Fabio Rossato 
Date: 26-04-2017
*/

For this project I've used two open source libraries:
- OHHTTPStubs library to stub the network requests during unit tests
- XCGLogger library for debug logging

I installed them using Cocoapod, a library dependency manager for Xcode projects.

-———————— IMPORTANT ——————————————————————————————————————————————————————-

Cocoapod uses a workspace to make the libraries available to the project, so please open the WTTest.xcworkspace
instead of WTTest.xcodeproj otherwise the project will not compile.

Project built with XCode 8.3.2, swift 3.1

————————————————————————-————————————————————————-————————————————————————-

The code has been written thinking about scalability and testability;

The classes are coded to allow dependency injection through the constructors to make easier writing unit tests and mocking objects.

The project is structured to keep the source files grouped by functionalities, so that it's easy to find them; All of the classes and files are using a prefix (WT: Weather test), that is a recommended practice, especially when working with other frameworks.

I developed the app following the TDD principles.
Unit tests and integration tests are included.
The UI tests are testing the basic views of the app.
The app has a good code coverage (around 90%).

I was able to keep the MVC model in place by using different controllers for the main view and the sub-collectionViews:
once the data is received, I separate the weather items by days in different arrays, each of them represents a dataSource for one collectionView.
The CollectionViewControllers are held by the WTWeekController, which instantiates them when a new row of the tableView is needed.
When the row is not displayed anymore, I delete the associated CollectionViewController to save memory: in this way if the same MainController will be used with a lot of rows I don't need to worry about the memory usage for the sub-collectionViewControllers; furthermore it follows the idea of reusable cells used by iOS.

There are 2 schemas, one to run both UI and UT tests, and one only for UITest.

For the purpose of the test I’m only showing weather for a predefined location (London), but the call in getWeather() is actually already parametrised if the app needs to be scaled for a user-selected city.

If I had got more time I would have increased the testing for the WTWeekController and the model objects. I would have also added customised messages to the end user while doing error handling.

I added a pull to refresh on the MainViewController so it's possible to get fresh weather data.
