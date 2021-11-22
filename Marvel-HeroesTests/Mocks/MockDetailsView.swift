//
//  MockDetailsView.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import UIKit

class MockDetailsView: DetailsViewControllerProtocol {
    
    var updateUISuccess = false
    var mockCharacterStatus: CharacterStatus = .free
    
    // MARK: - DetailsViewControllerProtocol
    
    func updateUI(characterStatus: CharacterStatus) {
        updateUISuccess = true
        mockCharacterStatus = characterStatus
    }
}
