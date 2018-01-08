//
//  Photo.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct Photo: Codable {

    struct URLS: Codable {
        let raw: URL
        let full: URL
        let regular: URL
        let small: URL
        let thumb: URL
    }

    struct Links: Codable {
        let purpleSelf: URL
        let html: URL
        let download: URL
        let downloadLocation: URL

        enum CodingKeys: String, CodingKey {
            case purpleSelf = "self"
            case html
            case download
            case downloadLocation = "download_location"
        }
    }

    struct Exif: Codable {
        let make: String?
        let model: String?
        let exposure: String?
        let aperature: String?
        let focalLength: String?
        let iso: Int?

        enum CodingKeys: String, CodingKey {
            case make
            case model
            case exposure = "exposure_time"
            case aperature
            case focalLength = "focal_length"
            case iso
        }
    }

    let id: String
    let createdAt, updatedAt: Date
    let width, height: Int
    let color: String
    let description: String?
//    let categories: [JSONAny]
    let urls: URLS
    let links: Links
    let likedByUser, sponsored: Bool
    let likes: Int
    let user: User
    let exif: Exif?
//    let currentUserCollections: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height
        case color
        case description
//        case categories
        case urls
        case links
        case likedByUser = "liked_by_user"
        case sponsored
        case likes
        case user
        case exif
//        case currentUserCollections = "current_user_collections"
    }
}
