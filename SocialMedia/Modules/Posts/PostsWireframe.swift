//
//  PostsWireframe.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class PostsWireframe: BaseWireframe {}

extension PostsWireframe: PostsWireframeInterface {
    // MARK: - Module setup -
    
    static func assembleWireframe() -> PostsWireframe {
        let viewController = PostsViewController.loadFromNib()
        let wireframe = PostsWireframe(viewController: viewController)
        
        let apiResponseHandler = APIResponseHandler()
        let apiErrorHandler = APIErrorHandler()
        let apiLayer = APILayer(apiResponseHandler: apiResponseHandler)
        
        let persistenceLayer = CoreDataStack()
        let dataStore = PostDataStore()
        
        let dataProvider = PostDataProvider(apiLayer: apiLayer,
                                            apiResponseHandler: apiResponseHandler,
                                            apiErrorHandler: apiErrorHandler,
                                            persistenceCreateLayer: persistenceLayer,
                                            persistenceReadLayer: persistenceLayer,
                                            persistenceUpdateLayer: persistenceLayer,
                                            dataStore: dataStore)
        
        let router = PostsRouter(viewController: viewController)
        let interactor = PostsInteractor(dataProvider: dataProvider)
        let presenter = PostsPresenter(view: viewController,
                                       interactor: interactor,
                                       router: router)
        
        interactor.output = presenter
        viewController.presenter = presenter
        
        return wireframe
    }
}
