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
    
    override func setUp() {
        mockRootView = MockRootView()
        mockNetworkService = MockNetworkService()
        viewModel = RootViewModel(mockNetworkService)
        
        viewModel.view = mockRootView
    }

    override func tearDown() {
        viewModel = nil
        mockRootView = nil
        mockNetworkService = nil
    }

    func test_fetchCharacters_with_success() throws {
        // Given
        mockRootView.reloadDataSuccess = false
        mockNetworkService.mockSuccess = true
        mockNetworkService.characters = [
            .init(
                id: 4,
                digitalID: 44,
                name: "Captain America",
                description: "The first avenger",
                title: "Captain America",
                thumbnail: nil
            )
        ]
        viewModel = RootViewModel(mockNetworkService)
        viewModel.view = mockRootView
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertTrue(mockRootView.reloadDataSuccess)
    }
    
    func test_fetchCharacters_with_error() throws {
        // Given
        mockRootView.reloadDataSuccess = false
        mockNetworkService.mockSuccess = false
        viewModel = RootViewModel(mockNetworkService)
        viewModel.view = mockRootView
        
        // When
        viewModel.fetchCharacters(offset: 0)
        
        // Then
        XCTAssertFalse(mockRootView.reloadDataSuccess)
    }


}
