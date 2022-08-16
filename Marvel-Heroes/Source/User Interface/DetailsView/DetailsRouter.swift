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

        return configuration.viewController
    }
    
    private static func configureModule(for character: Character) -> DetailsData {
        let router = DetailsRouter()
        let viewModel = DetailsViewModel(character)
        let viewController = DetailsViewController(viewModel)

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return DetailsData(viewController: viewController, viewModel: viewModel, router: router)
    }
    
    // MARK: - Routes
    
    func showAlert(error: APIErrorResponse) {
        DispatchQueue.main.async {
            let alertView = AlertRouter.getViewController(error: error)
            alertView.modalPresentationStyle = .custom
            self.viewController?.present(alertView, animated: false)
        }
    }
}

struct DetailsData {
    let viewController: DetailsViewController
    let viewModel: DetailsViewModel
    let router: DetailsRouter
}
