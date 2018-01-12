//
//  APIRequest.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

class APIEndpoint {

    let host: String
    var httpMethod: HTTPMethod = .get

    private var scheme: String = "https"
    private var path: String = "/"
    private var queryParameters = [URLQueryItem]()
    private var headerFields: [String: String]?
    private var body: Data?

    init(host: String) {
        self.host = host
    }

    // MARK: Builders

    func method(_ method: HTTPMethod) -> APIEndpoint {
        self.httpMethod = method
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

    func headerFields(_ fields: [String: String]) -> APIEndpoint {
        self.headerFields = fields
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
        request.allHTTPHeaderFields = headerFields
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body

        return request
    }
}

extension APIEndpoint {
    var description: String {
        return """
        \(String(describing: self)):

        Method: \(httpMethod.rawValue)
        Host: \(host)
        Path: \(path)
        """
    }
}
