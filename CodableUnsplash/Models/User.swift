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
        let html: URL
        let photos: URL
        let likes: URL
        let portfolio: URL
        let following: URL
        let followers: URL
    }

    let id: String
    let updatedAt: Date?
    let username, name: String
    let firstName: String
    let lastName: String?
    let twitterUsername: String?
    let portfolioUrl: URL?
    let bio: String?
    let location: String?
    let links: Links
    let profileImage: ProfileImage
    let totalLikes, totalPhotos, totalCollections: Int?
}

struct ProfileImage: Codable {
    let small: URL
    let medium: URL
    let large: URL
}
