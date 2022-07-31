//
//  MockDetailsRouter.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import UIKit

class MockDetailsRouter: DetailsRouter {
    
    var showAlertIsPresent = false
    var error: APIErrorResponse = .init(code: "", message: "")
    
    // MARK: - Helpers
    
    override func showAlert(error: APIErrorResponse) {
        self.error = error
        self.showAlertIsPresent = true
    }
}
