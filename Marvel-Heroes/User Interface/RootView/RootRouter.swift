//  RootRouter.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class RootRouter {
    
    // MARK: - Properties
    
    weak var viewController: RootViewController?

    // MARK: - Helpers
    
    static func getViewController() -> RootViewController {
        let configuration = configureModule()

        return configuration.vc
    }
    
    private static func configureModule() -> (vc: RootViewController, vm: RootViewModel, rt: RootRouter) {
        let viewController = RootViewController()
        let router = RootRouter()
        let viewModel = RootViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}