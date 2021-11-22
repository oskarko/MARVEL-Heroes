//
//  DataBaseManager.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import SQLite

protocol DataBaseProtocol {
    func addCharacter(_ character: Character)
    func existsCharacter(by ID: Int) -> Bool
    func getAllCharacters() -> [Character]
    func deleteCharacter(by ID: Int)
}

class DataBaseManager: DataBaseProtocol {
    
    func addCharacter(_ character: Character) {
        CharacterDAO.instance.addCharacter(character)
    }
    
    func existsCharacter(by ID: Int) -> Bool {
        CharacterDAO.instance.existsCharacter(by: ID)
    }
    
    func getAllCharacters() -> [Character] {
        CharacterDAO.instance.getAllCharacters()
    }
    
    func deleteCharacter(by ID: Int) {
        CharacterDAO.instance.deleteCharacter(by: ID)
    }
}
