//
//  DetailsService.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

protocol DetailsServiceProtocol {
    func fetch(_ request: DetailsRequest, completionHandler: @escaping (ResultResponse<DetailsResponse>) -> Void)
}

final class DetailsService: DetailsServiceProtocol {
    private let networkRequester: NetworkRequester

    init(networkRequester: NetworkRequester = .init()) {
        self.networkRequester = networkRequester
    }

    // MARK: - DetailsServiceProtocol Functions

    func fetch(_ request: DetailsRequest, completionHandler: @escaping (ResultResponse<DetailsResponse>) -> Void) {
        networkRequester.doRequest(request: request, completionHandler: completionHandler)
    }
}
