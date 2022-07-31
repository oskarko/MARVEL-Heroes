//
//  HomeViewModelTests.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import XCTest
@testable import Marvel_Heroes

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockHomeView: MockHomeView!
    var mockHomeRouter: MockHomeRouter!
    var mockHomeService: MockHomeService!
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
        mockHomeView = MockHomeView()
        mockHomeRouter = MockHomeRouter()
        mockHomeService = MockHomeService()
        mockDataBaseManager = MockDataBaseManager()
        viewModel = HomeViewModel(mockHomeService, dataBaseManager: mockDataBaseManager)
        
        viewModel.view = mockHomeView
        viewModel.router = mockHomeRouter
    }

    override func tearDown() {
        viewModel = nil
        mockHomeView = nil
        mockHomeRouter = nil
        mockHomeService = nil
        mockDataBaseManager = nil
    }

    func test_fetchCharacters_with_success() throws {
        // Given
        mockHomeView.reloadDataSuccess = false
        mockHomeService.mockSuccess = true
        mockHomeService.characters = [captainAmerica]
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertTrue(mockHomeView.reloadDataSuccess)
    }
    
    func test_fetchCharacters_with_error() throws {
        // Given
        mockHomeView.reloadDataSuccess = false
        mockHomeService.mockSuccess = false
        mockHomeRouter.showAlertIsPresent = false
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertFalse(mockHomeView.reloadDataSuccess)
        XCTAssertTrue(mockHomeRouter.showAlertIsPresent)
        XCTAssertTrue(mockHomeRouter.error.code == "Mock code")
        XCTAssertTrue(mockHomeRouter.error.message == "Mock Message")
    }
    
    func test_checkSquad_with_success() throws {
        // Given
        mockHomeView.drawHeaderSuccess = false
        mockDataBaseManager.characters = [captainAmerica]
        
        // When
        viewModel.checkSquad()
        
        // Then
        XCTAssertTrue(mockHomeView.drawHeaderSuccess)
    }
    
    func test_checkSquad_with_error() throws {
        // Given
        mockHomeView.drawHeaderSuccess = false
        mockDataBaseManager.characters = []
        
        // When
        viewModel.checkSquad()
        
        // Then
        XCTAssertFalse(mockHomeView.drawHeaderSuccess)
    }
    
    func test_cellModel_with_success() throws {
        // Given
        mockHomeService.characters = [captainAmerica]
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertTrue(viewModel.cellModel(at: 0).id == captainAmerica.id)
        XCTAssertTrue(viewModel.cellModel(at: 0).name == captainAmerica.name)
    }
    
    func test_prefetchRows_with_success() throws {
        // Given
        mockHomeService.characters = [captainAmerica, spiderman]
        
        // When
        viewModel.fetchCharacters(offset: 20)
        viewModel.prefetchRows(at: [IndexPath(row: 1, section: 0)])
        
        // Then
        XCTAssertTrue(mockHomeView.insertItemsSuccess)
    }
    
    func test_showDetailsView_with_success() throws {
        // Given
        mockHomeRouter.isShowDetailsViewPresented = false
        mockHomeService.characters = [captainAmerica, spiderman]
        
        // When
        viewModel.fetchCharacters(offset: 0)
        viewModel.didSelectRow(at: IndexPath(row: 1, section: 0))
        
        // Then
        XCTAssertTrue(mockHomeRouter.isShowDetailsViewPresented)
        XCTAssertEqual(mockHomeRouter.character?.id, spiderman.id)
        XCTAssertEqual(mockHomeRouter.character?.name, spiderman.name)
    }
}
