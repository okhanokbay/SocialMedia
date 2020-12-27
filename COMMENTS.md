
ReactiveSwift and RxSwift dependencies are added due to Moya's dependency in them, but they are not added to the project as per this issue states: https://github.com/Moya/Moya/issues/2012

Protocols -the ones that feels more like an interface- suffixed with Interface keyword. Other ones are suffixed with Protocol keyword. The "Protocol" ones are highly likely abstracting the models or view models. (e.g. actions -> Interface, objects -> Protocol)

Localization can be easliy added by using Strings.swift file.
