//
//  MockHomeRouter.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import UIKit

class MockHomeRouter: HomeRouter {
    
    var isShowDetailsViewPresented = false
    var showAlertIsPresent = false
    var error: APIErrorResponse = .init(code: "", message: "")
    var character: Character?
    
    // MARK: - Helpers
    
    override func showDetailsView(for character: Character) {
        self.character = character
        self.isShowDetailsViewPresented = true
    }
    
    override func showAlert(error: APIErrorResponse) {
        self.error = error
        self.showAlertIsPresent = true
    }
}
