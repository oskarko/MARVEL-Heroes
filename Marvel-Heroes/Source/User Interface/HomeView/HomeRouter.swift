//  HomeRouter.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class HomeRouter {
    
    // MARK: - Properties
    
    weak var viewController: HomeViewController?

    // MARK: - Helpers
    
    static func getViewController() -> UINavigationController {
        let configuration = configureModule()
        let nav = UINavigationController(rootViewController: configuration.viewController)

        return nav
    }
    
    private static func configureModule() -> HomeData {
        let router = HomeRouter()
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel)

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return HomeData(viewController: viewController, viewModel: viewModel, router: router)
    }
    
    // MARK: - Routes
    
    func showDetailsView(for character: Character) {
        let detailsView = DetailsRouter.getViewController(for: character)
        viewController?.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    func showAlert(error: APIErrorResponse) {
        DispatchQueue.main.async {
            let alertView = AlertRouter.getViewController(error: error)
            alertView.modalPresentationStyle = .custom
            self.viewController?.present(alertView, animated: false)
        }
    }
}

struct HomeData {
    let viewController: HomeViewController
    let viewModel: HomeViewModel
    let router: HomeRouter
}
