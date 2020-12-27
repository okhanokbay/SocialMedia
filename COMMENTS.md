
ReactiveSwift and RxSwift dependencies are added due to Moya's dependency in them, but they are not added to the project as per this issue states: https://github.com/Moya/Moya/issues/2012

Protocols -the ones that feels more like an interface- suffixed with Interface keyword. Other ones are suffixed with Protocol keyword. The "Protocol" ones are highly likely abstracting the models or view models. (e.g. actions -> Interface, objects -> Protocol)

Localization can be easliy added by using Strings.swift file.

Not used NSFetchedResultsController for Core Data. If I would, it would be very hard to isolate all the logic inside the CoreDataStack class. 

Things to develop: 
- Would modularize the project by creating a xcworkspace and defining subproject inside of it like SocialMediaNetwork, SocialMediaCore etc.
- Woulld like to add pull to refresh both in posts page and post detail page. Currently, the data is being used from the local warehouse after being fetched from the remote server only once. This is due to a requirement of the task pointed out in the README file ("...save user's data plan...") 
