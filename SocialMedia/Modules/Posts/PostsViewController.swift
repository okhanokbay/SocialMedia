//
//  PostsViewController.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class PostsViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: PostsPresenterInterface!

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

// MARK: - Extensions -

extension PostsViewController: PostsViewInterface {
}
