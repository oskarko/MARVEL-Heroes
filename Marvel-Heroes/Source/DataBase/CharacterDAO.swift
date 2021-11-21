//
//  CharacterDAO.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import SQLite

class CharacterDAO {
    static let instance = CharacterDAO()
    private let db: Connection?
    
    private let characterTable = Table("character")
    private let characterID = Expression<Int>("characterID")
    private let digitalID = Expression<Int>("DigitalID")
    private let name = Expression<String>("name")
    private let description = Expression<String>("description")
    private let title = Expression<String>("title")
    private let thumbnailPath = Expression<String>("thumbnailPath")
    private let thumbnailExtension = Expression<String>("thumbnailExtension")

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/MARVEL-Heroes.sqlite3")
        } catch {
            db = nil
            print("Unable to open database")
        }
        
        createTable()
    }
    
    func createTable() {
        do {
            try db?.run(characterTable.create(ifNotExists: true) { table in
                table.column(characterID, primaryKey: true)
                table.column(digitalID)
                table.column(name)
                table.column(description)
                table.column(title)
                table.column(thumbnailPath)
                table.column(thumbnailExtension)
            })
        }
        catch {
            print("Unable to create table")
        }
    }
    
    func addCharacter(_ character: Character) {
        do {
            var insert: Insert? = nil
            
            if !(existsCharacter(by: character.id)) {
                insert = characterTable.insert(
                    characterID <- character.id,
                    digitalID <- character.digitalID ?? -1,
                    name <- character.name.orEmpty,
                    description <- character.description.orEmpty,
                    title <- character.title.orEmpty,
                    thumbnailPath <- character.thumbnail?.path ?? "",
                    thumbnailExtension <- character.thumbnail?.fileExtension?.description ?? ""
                )
            }
            
            if let insert = insert {
                try db?.run(insert)
            }
        } catch {
            print("Insert failed")
        }
    }
    
    func existsCharacter(by ID: Int) -> Bool {
        var exists = false
        guard let dataBase = db else { return exists }
        
        do {
            for column in try dataBase.prepare(characterTable) {
                if ID == column[characterID] {
                    exists = true
                    break
                }
            }
        } catch {
            print("Exists character failed")
            return exists
        }
        
        return exists
    }
    
    func getAllCharacters() -> [Character] {
        var characters: [Character] = []
        guard let dataBase = db else { return characters }
        
        do {
            for column in try dataBase.prepare(characterTable) {
                characters.append(rowToCharacter(row: column))
            }
        } catch {
            print("Get All Characters failed")
            return characters
        }
        
        return characters
    }
    
    func deleteCharacter(by ID: Int) {
        do {
            let selectedCharacter = characterTable.filter(ID == characterID)
            try db?.run(selectedCharacter.delete())
        } catch {
            print("Delete character failed")
        }
    }
    
    // MARK: - Helper
    
    func rowToCharacter(row: Row) -> Character {
        Character(
            id: row[characterID],
            digitalID: row[digitalID],
            name: row[name],
            description: row[description],
            title: row[title],
            thumbnail: Thumbnail(
                path: row[thumbnailPath],
                fileExtension: Extension(
                    rawValue: row[thumbnailExtension]
                )
            )
        )
    }
}
