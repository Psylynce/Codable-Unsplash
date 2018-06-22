//
//  Photo.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

struct Photo: Codable {

    struct Links: Codable {
        let html: URL
        let download: URL
        let downloadLocation: URL
    }

    let id: String
    let createdAt: Date
    let updatedAt: Date?
    let width, height: Int
    let color: String
    let description: String?
    let urls: PhotoURLS
    let links: Links
    let likedByUser: Bool
    let sponsored: Bool?
    let likes: Int
    let user: User
    let exif: Exif?
    let location: Location?
}

extension Photo {
    var backgroundColor: UIColor {
        return UIColor(hex: color)
    }
}
