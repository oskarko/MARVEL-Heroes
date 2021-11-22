//
//  RootViewModelTests.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import XCTest
@testable import Marvel_Heroes

class RootViewModelTests: XCTestCase {

    var viewModel: RootViewModel!
    var mockRootView: MockRootView!
    var mockNetworkService: MockNetworkService!
    var mockDataBaseManager: MockDataBaseManager!
    
    // We could create some kind of (Mock) factory Heroes generator to generate random characters here.
    let captainAmerica: Character = .init(
        id: 4,
        digitalID: 44,
        name: "Captain America",
        description: "The first avenger",
        title: "Captain America",
        thumbnail: nil
    )
    
    let spiderman: Character = .init(
        id: 6,
        digitalID: 46,
        name: "Spiderman",
        description: "Hello, Peter...",
        title: "Spiderman",
        thumbnail: nil
    )
    
    override func setUp() {
        mockRootView = MockRootView()
        mockNetworkService = MockNetworkService()
        mockDataBaseManager = MockDataBaseManager()
        viewModel = RootViewModel(mockNetworkService, dataBaseManager: mockDataBaseManager)
        
        viewModel.view = mockRootView
    }

    override func tearDown() {
        viewModel = nil
        mockRootView = nil
        mockNetworkService = nil
        mockDataBaseManager = nil
    }

    func test_fetchCharacters_with_success() throws {
        // Given
        mockRootView.reloadDataSuccess = false
        mockNetworkService.mockSuccess = true
        mockNetworkService.characters = [captainAmerica]
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertTrue(mockRootView.reloadDataSuccess)
    }
    
    func test_fetchCharacters_with_error() throws {
        // Given
        mockRootView.reloadDataSuccess = false
        mockNetworkService.mockSuccess = false
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertFalse(mockRootView.reloadDataSuccess)
    }
    
    func test_checkSquad_with_success() throws {
        // Given
        mockRootView.drawHeaderSuccess = false
        mockDataBaseManager.characters = [captainAmerica]
        
        // When
        viewModel.checkSquad()
        
        // Then
        XCTAssertTrue(mockRootView.drawHeaderSuccess)
    }
    
    func test_checkSquad_with_error() throws {
        // Given
        mockRootView.drawHeaderSuccess = false
        mockDataBaseManager.characters = []
        
        // When
        viewModel.checkSquad()
        
        // Then
        XCTAssertFalse(mockRootView.drawHeaderSuccess)
    }
    
    func test_cellModel_with_success() throws {
        // Given
        mockNetworkService.characters = [captainAmerica]
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertTrue(viewModel.cellModel(at: 0).id == captainAmerica.id)
        XCTAssertTrue(viewModel.cellModel(at: 0).name == captainAmerica.name)
    }
    
    func test_prefetchRows_with_success() throws {
        // Given
        mockNetworkService.characters = [captainAmerica, spiderman]
        
        // When
        viewModel.fetchCharacters(offset: 20)
        viewModel.prefetchRows(at: [IndexPath(row: 1, section: 0)])
        
        // Then
        XCTAssertTrue(mockRootView.insertItemsSuccess)
    }
}
