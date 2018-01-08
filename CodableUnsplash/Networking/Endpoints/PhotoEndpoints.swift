//
//  PhotoEndpoints.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct PhotoEndpoint {
    static var listPhotos: APIEndpoint {
        return UnsplashEndpoint.configured.path("/photos")
    }

    static func fetchPhoto(id: String) -> APIEndpoint {
        return UnsplashEndpoint.configured.path("/photos/\(id)")
    }
}
