//
//  HomeService.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

protocol HomeServiceProtocol {
    func fetch(_ request: HomeRequest, completionHandler: @escaping (ResultResponse<HomeResponse>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    private let networkRequester: NetworkRequester

    init(networkRequester: NetworkRequester = .init()) {
        self.networkRequester = networkRequester
    }

    // MARK: - HomeServiceProtocol Functions

    func fetch(_ request: HomeRequest, completionHandler: @escaping (ResultResponse<HomeResponse>) -> Void) {
        networkRequester.doRequest(request: request, completionHandler: completionHandler)
    }
}
