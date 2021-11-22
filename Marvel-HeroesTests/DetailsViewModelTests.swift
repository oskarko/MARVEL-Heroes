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
    var mockDataBaseManager: MockDataBaseManager!
    
    let spiderman: Character = .init(
        id: 6,
        digitalID: 46,
        name: "Spiderman",
        description: "Hello, Peter...",
        title: "Spiderman",
        thumbnail: nil
    )
    
    override func setUp() {
        mockDetailsView = MockDetailsView()
        mockDataBaseManager = MockDataBaseManager()
        viewModel = DetailsViewModel(spiderman, dataBaseManager: mockDataBaseManager)
        
        viewModel.view = mockDetailsView
    }

    override func tearDown() {
        viewModel = nil
        mockDetailsView = nil
        mockDataBaseManager = nil
    }

    func test_getCharacterName_with_success() throws {
        // Given
        
        // When
        let characterName = viewModel.getCharacterName()
        
        // Then
        XCTAssertNotNil(characterName)
        XCTAssertTrue(characterName == spiderman.name)
    }
    
    func test_getCharacterHistory_with_success() throws {
        // Given
        
        // When
        let characterDescription = viewModel.getCharacterHistory()
        
        // Then
        XCTAssertNotNil(characterDescription)
        XCTAssertTrue(characterDescription == spiderman.description)
    }
    
    func test_getCharacterImageUrlString_with_error() throws {
        // Given
        
        // When
        let characterUrlString = viewModel.getCharacterImageUrlString()
        
        // Then
        XCTAssertNil(characterUrlString)
    }
    
    func test_getRecruitButtonTitle_with_character_exists() throws {
        // Given
        
        // When
        mockDataBaseManager.characterExists = true
        let buttonTitle = viewModel.getRecruitButtonTitle()
        
        // Then
        XCTAssertTrue(buttonTitle == "🔥  Fire from Squad")
    }
    
    func test_getRecruitButtonTitle_with_character_NOT_exists() throws {
        // Given
        
        // When
        mockDataBaseManager.characterExists = false
        let buttonTitle = viewModel.getRecruitButtonTitle()
        
        // Then
        XCTAssertTrue(buttonTitle == "💪  Recruit to Squad")
    }
    
    func test_getCharacterStatus_with_character_exists() throws {
        // Given
        
        // When
        mockDataBaseManager.characterExists = true
        let characterStatus = viewModel.getCharacterStatus()
        
        // Then
        XCTAssertTrue(characterStatus == .hired)
    }
    
    func test_getCharacterStatus_with_character_NOT_exists() throws {
        // Given
        
        // When
        mockDataBaseManager.characterExists = false
        let characterStatus = viewModel.getCharacterStatus()
        
        // Then
        XCTAssertTrue(characterStatus == .free)
    }
    
    func test_recruitButtonTapped_with_character_exists() throws {
        // Given
        
        // When
        mockDetailsView.updateUISuccess = false
        mockDataBaseManager.characterExists = true
        mockDataBaseManager.characterSuccessfullyDeleted = false
        viewModel.recruitButtonTapped()
        
        // Then
        XCTAssertTrue(mockDataBaseManager.characterSuccessfullyDeleted)
        XCTAssertTrue(mockDetailsView.updateUISuccess)
        XCTAssertTrue(mockDetailsView.mockCharacterStatus == .hired)
    }
    
    func test_recruitButtonTapped_with_character_NOT_exists() throws {
        // Given
        
        // When
        mockDetailsView.updateUISuccess = false
        mockDataBaseManager.characterExists = false
        mockDataBaseManager.characterSuccessfullyAdded = false
        viewModel.recruitButtonTapped()
        
        // Then
        XCTAssertTrue(mockDataBaseManager.characterSuccessfullyAdded)
        XCTAssertTrue(mockDetailsView.updateUISuccess)
        XCTAssertTrue(mockDetailsView.mockCharacterStatus == .free)
    }
}
