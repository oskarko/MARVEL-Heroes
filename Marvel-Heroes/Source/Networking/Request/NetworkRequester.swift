//
//  NetworkRequester.swift
//  Marvel-Heroes
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct NetworkRequester {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func requestService<T: Decodable>(request: NetworkRequest, completion: @escaping (ResultResponse<T>) -> Void) {
        session.dataTask(with: request.request, completionHandler: { data, response, requestError in
            if let requestError = requestError {
                completion(.failure(.init(message: requestError.localizedDescription)))
                return
            }
            guard let dataResponse = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // handling errors
            if let urlResponse = response as? HTTPURLResponse {
                switch urlResponse.statusCode {
                case 400...530:
                    do {
                        let error = try mapResponse(data: dataResponse, dataType: APIErrorResponse.self)
                        print(error)
                        completion(.failure(error))
                        return
                    } catch {
                        print(error)
                        completion(.failure(.init(message: error.localizedDescription)))
                        return
                    }
                default: break
                }
            }
            
            do {
                let mappedResponse = try mapResponse(data: dataResponse, dataType: T.self)
                completion(.success(mappedResponse))
                return
            } catch {
                print(error)
                completion(.failure(.invalidJSON))
                return
            }
        }).resume()
    }

    private func mapResponse<T: Decodable>(data: Data, dataType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

extension NetworkRequester {
    func doRequest<T: Decodable>(request: APIRequest,
                                 completionHandler: @escaping (ResultResponse<T>) -> Void) {
        requestService(request: NetworkRequest(apiRequest: request)) { (result: ResultResponse<T>) in
            switch result {
            case let .success(response):
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
