# VelvetVibe 

* VelvetVibe is a iOS application built with SwiftUI, aiming to provide users with a smooth and visually captivating shopping journey.
* Fetches products data from https://dummyjson.com/products

# Required Capstone App Functionality

* Xcode 17.0
* The app does not use any third-party frameworks: No third party used
* The app has a launch screen suitable for the app: Has Launch Screen View
* All features in the app should be completed:  Unfinished feature are in different branch
* The app has at least one screen with a list using a view of your choice (List, Grid, ScrollView etc): I used these view in AllProductView, CheckoutView
* This list should appear in a tab view with at least two tabs. My app has 5 tab View
* Each item in the list should contain (at minimum) a name, a subtitle or description, and an image of the item: User can see item name, description and Image
* Tapping an item in this list should navigate (NavigationStack)  to a detail view: This should show the same data in the list item with some further details such as a longer description, bigger picture, price, or a Buy/Order button: Completed
* Include enough items to ensure that the user has to scroll the list to see all the items in it: Scroll the list to see all the products and categories
* The app has one or more network calls using URLSession to download/upload data related to the core tasks of the app: Completed
* The app handles all typical errors related to network calls — including server error response codes and no network connection — and keeps the user informed: Covered all the error of network calls.
* The app uses at least one way to save data: user defaults, plist, file, or keychain:
* The app uses Swift Modern Concurrency, async/await, and MainActor appropriately to keep slow-running tasks off the main thread and to update the UI on the main thread. No dispatch queues or completion handlers: Completed
* The app communicates to the user whenever data is missing or empty, the reason for that condition — for example, data cannot be loaded, or the user hasn’t created any — and the action the user should perform to move forward. The app should have no blank screens, and the user should never feel “lost”: Completed
* Views work for landscape and portrait orientations for the full range of iPhone sizes, including iPhone SE 2: Work in both orientations
* Views work for both light and dark modes: working in light and dark mode: completed
* There are no obvious UI issues, like UI components overlapping or running off the screen: Completed
* Project source files are organized in folders such as Views, Models, Networking etc: Completed
* View components are abstracted into separate Views and source files: Completed
* The project uses MVVM architecture: The Model includes at least one ObservableObject with at least one Published value that at least one view subscribes to. Networking code is in a Service struct or class that can be instantiated by an ObservableObject: Completed
* The project utilizes SwiftLint with Kodeco’s configuration file: Completed
* The app builds without Warnings or Errors: Builds without error
* The project has a test plan including both UI and unit tests, with a minimum of 50% code coverage, and all tests succeed. Make sure your test plan is in your repo: Code coverage above 60%
* A custom app icon: Completed
* An onboarding screen: Completed
* A custom display name: Completed
* At least one SwiftUI animation: Have two SwiftUI animation

