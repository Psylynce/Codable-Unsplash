//
//  Location.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/11/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

public struct Location: Codable {

    public struct Position: Codable {
        public let latitude: Double
        public let longitude: Double
    }

    public let name: String
    public let title: String
    public let city: String?
    public let country: String
    public let position: Position
}
