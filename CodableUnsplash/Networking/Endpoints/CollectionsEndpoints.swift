//
//  CollectionsEndpoints.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct CollectionsEndpoints {
    static func featuredCollections(page: Int = 1) -> APIEndpoint {
        let pageParams = URLQueryItem(name: "page", value: "\(page)")
        return UnsplashEndpoint.configured.path("/collections/featured").queryParameters([pageParams])
    }

    static func fetchCollectionPhotos(id: Int, page: Int = 1) -> APIEndpoint {
        let pageParams = URLQueryItem(name: "page", value: "\(page)")
        return UnsplashEndpoint.configured.path("/collections/\(id)/photos").queryParameters([pageParams])
    }
}
