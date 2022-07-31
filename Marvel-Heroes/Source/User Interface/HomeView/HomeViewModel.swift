//  HomeViewModel.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    weak var view: HomeViewControllerProtocol?
    var router: HomeRouter?
    
    private var dataBaseManager: DataBaseProtocol
    private let service: HomeServiceProtocol
    private var characters: [Character] = []
    private var offset: Int = 0
    
    /// Computed properties
    var numberOfCharacters: Int {
        characters.count
    }
    
    // MARK: - Lifecycle
    
    init(
        _ service: HomeServiceProtocol = HomeService(),
        dataBaseManager: DataBaseProtocol = DataBaseManager()
    ) {
        self.service = service
        self.dataBaseManager = dataBaseManager
    }
    
    func fetchCharacters(offset: Int) {
        self.offset = offset
        let model = HomeRequestModel(limit: "\(CHARACTERS_BY_PAGE)", offset: "\(offset)")
        service.fetch(HomeRequest.characters(model)) { [weak self] result in
            guard let self = self else { return }
            
            self.view?.dismissActivityIndicator()
            
            switch result {
            case let .success(response):
                    let newCharacters = response.data.items
                    self.updateCharacters(newCharacters)
            case let .failure(error):
                self.router?.showAlert(error: error)
            }
        }
    }
    
    func checkSquad() {
        let allCharacters = dataBaseManager.getAllCharacters()
        view?.drawHeader(with: allCharacters)
    }
    
    private func updateCharacters(_ newCharacters: [Character]) {
        if offset > 0 {
            characters.append(contentsOf: newCharacters)
            let indexPathsToRelod = calculateIndexPathsToReload(from: newCharacters)
            view?.insertItems(at: indexPathsToRelod)
        } else {
            characters = newCharacters
            view?.reloadData()
        }
    }
    
    func cellModel(at index: Int) -> Character {
        characters[index]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let character = characters[indexPath.row]
        router?.showDetailsView(for: character)
    }
    
    func prefetchRows(at indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLastCell) {
            fetchCharacters(offset: characters.count)
        }
    }
    
    func didSelect(character: Character) {
        router?.showDetailsView(for: character)
    }
    
    // MARK: - Helpers
    
    // This method helps to calculate if a cell is the last one in the tableView.
    private func isLastCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == characters.count - 1 && characters.count % CHARACTERS_BY_PAGE == 0
    }
    
    private func calculateIndexPathsToReload(from newCharacters: [Character]) -> [IndexPath] {
      let startIndex = characters.count - newCharacters.count
      let endIndex = startIndex + newCharacters.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
