//
//  APIRequest.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

class APIEndpoint {

    var httpMethod: HTTPMethod = .get

    private var host: String
    private var scheme: String = "https"
    private var path: String = "/"
    private var queryParameters = [URLQueryItem]()
    private var body: Data?

    init(host: String) {
        self.host = host
    }

    // MARK: Builders

    func method(_ method: HTTPMethod) -> APIEndpoint {
        self.httpMethod = method
        return self
    }

    func host(_ host: String) -> APIEndpoint {
        self.host = host
        return self
    }

    func path(_ path: String) -> APIEndpoint {
        self.path = path
        return self
    }

    func queryParameters(_ params: [URLQueryItem]) -> APIEndpoint {
        self.queryParameters = params
        return self
    }

    func body(_ body: Data) -> APIEndpoint {
        self.body = body
        return self
    }

    // MARK: Request

    func request() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path

        if queryParameters.isEmpty == false {
            urlComponents.queryItems = queryParameters
        }

        guard let urlComponentsURL = urlComponents.url else { fatalError("Could not create a url with the components: \(urlComponents)") }

        var request = URLRequest(url: urlComponentsURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body

        return request
    }
}
