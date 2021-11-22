//
//  MockDataBaseManager.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import Foundation

class MockDataBaseManager: DataBaseProtocol {
    
    var characters = [Character]()
    var characterSuccessfullyAdded = false
    var characterExists = false
    var characterSuccessfullyDeleted = false
    
    func addCharacter(_ character: Character) {
        characterSuccessfullyAdded = true
    }
    
    func existsCharacter(by ID: Int) -> Bool {
        characterExists
    }
    
    func getAllCharacters() -> [Character] {
        characters
    }
    
    func deleteCharacter(by ID: Int) {
        characterSuccessfullyDeleted = true
    }
}
