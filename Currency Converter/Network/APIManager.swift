//
//  APIManager.swift
//  Currency Converter
//
//  Created by Misael on 22/09/23.
//

import Foundation

enum HTTPError: Error {
    case failedResponse
    case failedDecoding
    case invalidUrl
    case invalidData
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

struct APIConfig {
    let url: String
    let httpMethod: HTTPMethod
    var headers: [String : String]?
    var params: [String : String]?
    
    init(url: String, httpMethod: HTTPMethod, headers: [String : String]? = nil, params: [String : String]? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.headers = headers
        self.params = params
    }
}

protocol HTTPClient {
    func request<T: Decodable>(request: URLRequest,
                               completion: @escaping (Result<T, HTTPError>) -> Void)
}

class APIManager: HTTPClient {
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, HTTPError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let urlResponse = urlResponse as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                completion(.failure(.failedResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.failedDecoding))
            }
        }.resume()
    }
}
