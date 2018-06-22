//
//  Collection.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct Collection: Codable {
    let id: Int
    let title: String
    let description: String?
    let publishedAt: Date
    let totalPhotos: Int
    let coverPhoto: Photo
}
