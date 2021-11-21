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

class DataBaseManager {
    
    static let instance = DataBaseManager()
    
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
