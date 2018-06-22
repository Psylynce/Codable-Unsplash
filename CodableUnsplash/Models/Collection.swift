//
//  Collection.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct Collection: Codable {

    struct PreviewPhoto: Codable {
        let urls: PhotoURLS
    }

    let id: Int
    let title: String
    let description: String?
    let publishedAt: Date
    let totalPhotos: Int
    let coverPhoto: Photo
    let previewPhotos: [PreviewPhoto]
    let user: User
}
