


SOLID principles that are utilized in the project:

S -> by separating logic into APILayer, APIResponseHandler, APIErrorHandler
These 3 are getting together in PostDataProvider and that class' only responsibility is to redirect calls and to provide a synchronization point

O -> Providing a PersistenceLayerInterface for local data CRUD operations

L -> AFAIK, Interface Segregation and POP leads you to a place where you hardly face a Liskov Substitution kind of problem. Also you have to be careful about it.

I -> by using different interfaces for PersistenceLayer's CRUD Operations -> PersistenceCreateLayer, PersistenceReadLayer, PersistenceUpdateLayer

D -> Abstracting the logic in protocols and injecting them into needed contexts



ARCHITECTURAL DECISIONS: 

Is VIPER. I like it more than Clean Swift, MVVM and MVP. Find it easier to use related to others.

Used Swift Package Manager. ReactiveSwift and RxSwift dependencies are added due to Moya's dependency in them, but they are not added to the project as per this issue states: https://github.com/Moya/Moya/issues/2012

Checked the codebase with a SwiftLint constraint.



THIRD PARTY LIBS:

- Moya -> Abstracts the NetworkLayer very well and provides a easy to consume programming interface. Uses the robust Alamofire as it's root to reach the remote server.
- NVActivityIndicatorView -> No reason. Just loved the animation :) 



THINGS TO DEVELOP FURTHER IN A WIDER TIMEFRAME:

- Would modularize the project by creating a xcworkspace and defining subproject inside of it like SocialMediaNetwork, SocialMediaCore etc.

- Woulld like to add pull to refresh both in posts page and post detail page. Currently, the data is being used from the local warehouse after being fetched from the remote server only once. This is due to a requirement of the task pointed out in the README file ("...save user's data plan...") 

- Write more unit tests and try to cover most possible percentage of the code. For now, only included some unit tests to demonstrate knowledge



OTHERS: 

Protocols -the ones that feels more like an interface- suffixed with Interface keyword. Other ones are suffixed with Protocol keyword. The "Protocol" ones are highly likely abstracting the models or view models. (e.g. actions -> Interface, objects -> Protocol)

Localization can be easliy added by using Strings.swift file.

Not used NSFetchedResultsController for Core Data. If I would, it would be very hard to isolate all the logic inside the CoreDataStack class. 
