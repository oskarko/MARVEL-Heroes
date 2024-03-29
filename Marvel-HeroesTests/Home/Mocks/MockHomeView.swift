//
//  MockHomeView.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

@testable import Marvel_Heroes
import UIKit

class MockHomeView: HomeViewControllerProtocol {
    
    var isActivityIndicatorDismissed = false
    var reloadDataSuccess = false
    var insertItemsSuccess = false
    var drawHeaderSuccess = false
    
    // MARK: - HomeViewControllerProtocol
    
    func dismissActivityIndicator() {
        isActivityIndicatorDismissed = true
    }
    
    func reloadData() {
        reloadDataSuccess = true
    }
    
    func insertItems(at indexPathsToReload: [IndexPath]) {
        insertItemsSuccess = true
    }
    
    func drawHeader(with characters: [Character]) {
        drawHeaderSuccess = !characters.isEmpty
    }
}
