//  DetailsRouter.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class DetailsRouter {
    
    // MARK: - Properties
    
    weak var viewController: DetailsViewController?

    // MARK: - Helpers
    
    static func getViewController(for character: Character) -> DetailsViewController {
        let configuration = configureModule(for: character)

        return configuration.vc
    }
    
    private static func configureModule(for character: Character) -> (vc: DetailsViewController, vm: DetailsViewModel, rt: DetailsRouter) {
        let viewController = DetailsViewController()
        let router = DetailsRouter()
        let viewModel = DetailsViewModel(character)

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}
