//
//  UnsplashEndpoint.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct UnsplashEndpoint {

    static var apiKey: String {
        guard let plistFile = Bundle.main.path(forResource: "APIKeys", ofType: "plist") else { return "" }
        let plist = NSDictionary(contentsOfFile: plistFile) as? Dictionary<String, Any>

        return plist?["unsplashAPIKey"] as? String ?? ""
    }

    static let headerFields = [
        "Accept-Version": "v1",
        "Authorization": "Client-ID \(apiKey)"
    ]

    static var configured: APIEndpoint {
        return APIEndpoint(host: "api.unsplash.com").headerFields(headerFields)
    }
}
