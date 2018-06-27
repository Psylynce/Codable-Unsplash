//
//  SearchResults.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/27/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct SearchResults<T: Codable>: Codable {

    let totalPages: Int
    let results: [T]
}
