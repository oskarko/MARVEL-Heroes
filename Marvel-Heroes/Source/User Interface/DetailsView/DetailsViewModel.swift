//  DetailsViewModel.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    // MARK: - Properties
    
    weak var view: DetailsViewControllerProtocol?
    var router: DetailsRouter?
    private var character: Character
    private var dataBaseManager: DataBaseProtocol
    private let service: DetailsServiceProtocol
    
    // MARK: - Lifecycle
    
    init(
        _ character: Character,
        service: DetailsServiceProtocol = DetailsService(),
        dataBaseManager: DataBaseProtocol = DataBaseManager()
    ) {
        self.character = character
        self.service = service
        self.dataBaseManager = dataBaseManager
    }
    
    // MARK: - Helpers
    
    func fetchCharacter() {
        let model = DetailsRequestModel(ID: "\(character.id)")
        service.fetch(DetailsRequest.character(model)) { [weak self] result in
            guard let self = self else { return }
            
            self.view?.dismissActivityIndicator()
            
            switch result {
            case let .success(response):
                if let firstCharacter = response.data.items.first {
                    self.character = firstCharacter
                    self.view?.updateUI(characterStatus: self.getCharacterStatus())
                }
            case let .failure(error):
                self.router?.showAlert(error: error)
            }
        }
    }
    
    func getCharacterName() -> String? {
        character.name
    }
    
    func getCharacterHistory() -> String? {
        character.description
    }
    
    func getCharacterImageUrlString() -> String? {
        guard
            let path = character.thumbnail?.path,
            let fileExtension = character.thumbnail?.fileExtension?.description,
            !path.contains("image_not_available")
        else {
            return nil
        }
        
        return path + "." + fileExtension
    }
    
    func getRecruitButtonTitle() -> String? {
        dataBaseManager.existsCharacter(by: character.id) ? "🔥  Fire from Squad" : "💪  Recruit to Squad" // 🚧 This text should be localized.
    }
    
    private func getCharacterStatus() -> CharacterStatus {
        dataBaseManager.existsCharacter(by: character.id) ? .hired : .free
    }
    
    func recruitButtonTapped() {
        if dataBaseManager.existsCharacter(by: character.id) {
            dataBaseManager.deleteCharacter(by: character.id)
        } else {
            dataBaseManager.addCharacter(character)
        }

        view?.updateUI(characterStatus: getCharacterStatus())
    }
}
