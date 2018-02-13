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

extension Exif {
    var rows: [TitleValueRow] {
        var newRows = [TitleValueRow]()

        if let make = make {
            newRows.append(TitleValueRow(title: "Make", value: make))
        }

        if let model = model {
            newRows.append(TitleValueRow(title: "Model", value: model))
        }

        if let exposure = exposure {
            newRows.append(TitleValueRow(title: "Exposure", value: exposure))
        }

        if let aperture = aperture {
            newRows.append(TitleValueRow(title: "Aperture", value: aperture))
        }

        if let focalLength = focalLength {
            newRows.append(TitleValueRow(title: "Focal Length", value: focalLength))
        }

        if let iso = iso {
            newRows.append(TitleValueRow(title: "ISO", value: "\(iso)"))
        }

        return newRows
    }
}
