# NikeCodingTest

**Project Architecture Pattern:**<br />
MVVM-Navigation architecture pattern used in this project to organize the source code in different modules. Standard MVVM with an extra module navigation that
will handle the navigation between the screens and dependency injection while creating the appropriate screens to navigate.

**Bindings:**<br />
Native Combine framework has been used for the UI bindings between view controller -> view model and view model -> model. 

**UI:**<br />
UI is made programatically with the help of auto layouts and extensive use of stack views.

**Unit Testing:**<br />
Unit testing is done to test the business logic in view models by XCTest framework. Mock functionality of navigation and service layer injected in view models 
with help of dependency injection.


**Motivation and helping material:**<br />
https://www.onswiftwings.com/posts/reusable-image-cache/<br />
https://www.swiftbysundell.com/articles/building-dsls-in-swift/<br />
https://github.com/sergdort/CleanArchitectureRxSwift<br />