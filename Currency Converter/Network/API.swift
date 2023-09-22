//
//  API.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//

import Foundation

class API {
    private let apiConfig: APIConfig
    private let apiManager: HTTPClient

    init(apiConfig: APIConfig, apiManager: HTTPClient) {
        self.apiConfig = apiConfig
        self.apiManager = apiManager
    }
}

extension API {
    func fetch<T>(completion: @escaping (Result<T,HTTPError>) -> Void) where T : Decodable {
        
        guard var urlComponent = URLComponents(string: apiConfig.url) else {
            return completion(.failure(.invalidUrl))
        }
        
        var queryItems: [URLQueryItem] = []
                
        apiConfig.params?.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else {
            return completion(.failure(.invalidUrl))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiConfig.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = apiConfig.headers

        apiManager.request(request: urlRequest) { result in
            completion(result)
        }
    }
}
