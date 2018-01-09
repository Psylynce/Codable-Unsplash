//
//  Exif.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

public struct Exif: Codable {
    public let make: String?
    public let model: String?
    public let exposure: String?
    public let aperture: String?
    public let focalLength: String?
    public let iso: Int?

    enum CodingKeys: String, CodingKey {
        case make
        case model
        case exposure = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
}

public struct ExifRow {
    public let title: String
    public let value: String
}

extension Exif {
    var rows: [ExifRow] {
        var newRows = [ExifRow]()

        if let make = make {
            newRows.append(ExifRow(title: "Make", value: make))
        }

        if let model = model {
            newRows.append(ExifRow(title: "Model", value: model))
        }

        if let exposure = exposure {
            newRows.append(ExifRow(title: "Exposure", value: exposure))
        }

        if let aperture = aperture {
            newRows.append(ExifRow(title: "Aperture", value: aperture))
        }

        if let focalLength = focalLength {
            newRows.append(ExifRow(title: "Focal Length", value: focalLength))
        }

        if let iso = iso {
            newRows.append(ExifRow(title: "ISO", value: "\(iso)"))
        }

        return newRows
    }
}
