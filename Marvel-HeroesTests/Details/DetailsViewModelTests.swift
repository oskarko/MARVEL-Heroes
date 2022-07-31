//
//  DetailsViewModelTests.swift
//  Marvel-HeroesTests
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import XCTest
@testable import Marvel_Heroes

class DetailsViewModelTests: XCTestCase {

    var viewModel: DetailsViewModel!
    var mockDetailsView: MockDetailsView!
    var mockDetailsRouter: MockDetailsRouter!
    var mockDetailsService: MockDetailsService!
    var mockDataBaseManager: MockDataBaseManager!
    
    let captainAmerica: Character = .init(
        id: 4,
        digitalID: 44,
        name: "Captain America",
        description: "The first avenger",
        title: "Captain America",
        thumbnail: nil
    )
    
    override func setUp() {
        mockDetailsView = MockDetailsView()
        mockDetailsRouter = MockDetailsRouter()
        mockDetailsService = MockDetailsService()
        mockDataBaseManager = MockDataBaseManager()
        viewModel = DetailsViewModel(captainAmerica,
                                     service: mockDetailsService,
                                     dataBaseManager: mockDataBaseManager)
        
        viewModel.view = mockDetailsView
        viewModel.router = mockDetailsRouter
    }

    override func tearDown() {
        viewModel = nil
        mockDetailsView = nil
        mockDetailsRouter = nil
        mockDetailsService = nil
        mockDataBaseManager = nil
    }

    func test_getCharacterName_with_success() throws {
        // Given
        mockDetailsService.mockSuccess = true
        mockDetailsService.characters = [captainAmerica]
        mockDetailsRouter.showAlertIsPresent = false
        
        // When
        viewModel.fetchCharacter()
        let characterName = viewModel.getCharacterName()
        
        // Then
        XCTAssertNotNil(characterName)
        XCTAssertTrue(characterName == captainAmerica.name)
        XCTAssertFalse(mockDetailsRouter.showAlertIsPresent)
    }
    
    func test_getCharacterHistory_with_success() throws {
        // Given
        mockDetailsService.mockSuccess = true
        mockDetailsService.characters = [captainAmerica]
        mockDetailsRouter.showAlertIsPresent = false
        
        // When
        viewModel.fetchCharacter()
        let characterDescription = viewModel.getCharacterHistory()
        
        // Then
        XCTAssertNotNil(characterDescription)
        XCTAssertTrue(characterDescription == captainAmerica.description)
        XCTAssertFalse(mockDetailsRouter.showAlertIsPresent)
    }
    
    func test_getCharacterImageUrlString_with_error() throws {
        // Given
        mockDetailsService.mockSuccess = false
        mockDetailsService.characters = []
        mockDetailsRouter.showAlertIsPresent = false
        
        // When
        viewModel.fetchCharacter()
        let characterUrlString = viewModel.getCharacterImageUrlString()
        
        // Then
        XCTAssertNil(characterUrlString)
        XCTAssertTrue(mockDetailsRouter.showAlertIsPresent)
        XCTAssertTrue(mockDetailsRouter.error.code == "Mock code")
        XCTAssertTrue(mockDetailsRouter.error.message == "Mock Message")
    }
    
    func test_getRecruitButtonTitle_with_character_exists() throws {
        // Given
        mockDetailsService.mockSuccess = true
        mockDetailsService.characters = [captainAmerica]
        mockDetailsRouter.showAlertIsPresent = false
        
        // When
        mockDataBaseManager.characterExists = true
        viewModel.fetchCharacter()
        let buttonTitle = viewModel.getRecruitButtonTitle()
        
        // Then
        XCTAssertTrue(buttonTitle == "🔥  Fire from Squad")
        XCTAssertFalse(mockDetailsRouter.showAlertIsPresent)
    }
    
    func test_getRecruitButtonTitle_with_character_NOT_exists() throws {
        // Given
        mockDetailsService.mockSuccess = true
        mockDetailsService.characters = [captainAmerica]
        
        // When
        mockDataBaseManager.characterExists = false
        viewModel.fetchCharacter()
        let buttonTitle = viewModel.getRecruitButtonTitle()
        
        // Then
        XCTAssertTrue(buttonTitle == "💪  Recruit to Squad")
    }
    
    func test_recruitButtonTapped_with_character_exists() throws {
        // Given
        mockDetailsService.mockSuccess = true
        mockDetailsService.characters = [captainAmerica]
        mockDetailsView.updateUISuccess = false
        mockDataBaseManager.characterSuccessfullyDeleted = false
        
        // When
        mockDataBaseManager.characterExists = true
        viewModel.fetchCharacter()
        viewModel.recruitButtonTapped()
        
        // Then
        XCTAssertTrue(mockDataBaseManager.characterSuccessfullyDeleted)
        XCTAssertTrue(mockDetailsView.updateUISuccess)
        XCTAssertTrue(mockDetailsView.mockCharacterStatus == .hired)
    }
    
    func test_recruitButtonTapped_with_character_NOT_exists() throws {
        // Given
        mockDetailsService.mockSuccess = true
        mockDetailsService.characters = [captainAmerica]
        mockDetailsView.updateUISuccess = false
        mockDataBaseManager.characterSuccessfullyAdded = false
        
        // When
        mockDataBaseManager.characterExists = false
        viewModel.fetchCharacter()
        viewModel.recruitButtonTapped()
        
        // Then
        XCTAssertTrue(mockDataBaseManager.characterSuccessfullyAdded)
        XCTAssertTrue(mockDetailsView.updateUISuccess)
        XCTAssertTrue(mockDetailsView.mockCharacterStatus == .free)
    }
}
