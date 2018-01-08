//
//  User.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct User: Codable {

    struct Links: Codable {
        let purpleSelf: URL
        let html: URL
        let photos: URL
        let likes: URL
        let portfolio: URL
        let following: URL
        let followers: URL

        enum CodingKeys: String, CodingKey {
            case purpleSelf = "self"
            case html
            case photos
            case likes
            case portfolio
            case following
            case followers
        }
    }

    let id: String
    let updatedAt: Date
    let username, name: String
    let firstName: String
    let lastName: String?
    let twitterUsername: String?
    let portfolioURL: URL?
    let bio: String?
    let location: String?
    let links: Links
    let profileImage: ProfileImage
    let totalLikes, totalPhotos, totalCollections: Int

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio
        case location
        case links
        case profileImage = "profile_image"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
    }
}

struct ProfileImage: Codable {
    let small: URL
    let medium: URL
    let large: URL
}
