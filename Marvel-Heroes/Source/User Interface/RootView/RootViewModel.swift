//  RootViewModel.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class RootViewModel {
    
    // MARK: - Properties
    
    weak var view: RootViewControllerProtocol?
    var router: RootRouter?
    private var networkService: NetworkProtocol
    private var characters: [Character] = []
    private var offset: Int = 0
    
    /// Computed properties
    var numberOfCharacters: Int {
        characters.count
    }
    
    // MARK: - Lifecycle
    
    init(_ networkService: NetworkProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCharacters(offset: Int) {
        self.offset = offset
        networkService.fetch(ofType: .characters(CHARACTERS_BY_PAGE, offset), onComplete: updateCharacters)
    }
    
    private func updateCharacters(response: Result<MarvelData<Character>>) {
        switch response {
            case .success(let response):
                let newCharacters = response.data.items
                if offset > 0 {
                    self.characters.append(contentsOf: newCharacters)
                    let indexPathsToRelod = calculateIndexPathsToReload(from: newCharacters)
                    view?.insertItems(at: indexPathsToRelod)
                } else {
                    self.characters = newCharacters
                    view?.reloadData()
                }
            case .fail(let error):
                print("DEBUG: Something went wrong. Error: \(error.localizedDescription)")
        }
    }
    
    func cellModel(at index: Int) -> Character {
        characters[index]
    }
    
    func prefetchRows(at indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLastCell) {
            fetchCharacters(offset: characters.count)
        }
    }
    
    // This method helps to calculate if a cell is the last one in the tableView.
    private func isLastCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == characters.count - 1 && characters.count % CHARACTERS_BY_PAGE == 0
    }
    
    // MARK: - Helpers
    
    private func calculateIndexPathsToReload(from newCharacters: [Character]) -> [IndexPath] {
      let startIndex = characters.count - newCharacters.count
      let endIndex = startIndex + newCharacters.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
