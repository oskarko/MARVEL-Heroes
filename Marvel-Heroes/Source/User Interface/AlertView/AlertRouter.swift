//  AlertRouter.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class AlertRouter {
    
    // MARK: - Properties
    
    weak var viewController: AlertViewController?

    // MARK: - Helpers
    
    static func getViewController(error: APIErrorResponse) -> AlertViewController {
        let configuration = configureModule(error: error)

        return configuration.vc
    }
    
    private static func configureModule(error: APIErrorResponse) -> (vc: AlertViewController,
                                                                         vm: AlertViewModel,
                                                                         rt: AlertRouter) {
        
        let viewController = AlertViewController()
        let router = AlertRouter()
        let viewModel = AlertViewModel(error)

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
    func dismiss() {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: false)
        }
    }
}
