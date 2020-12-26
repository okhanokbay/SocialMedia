//
//  PresenterInterface.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

protocol PresenterInterface: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

extension PresenterInterface {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
