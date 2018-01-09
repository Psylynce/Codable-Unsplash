//
//  Exif.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct Exif: Codable {
    let make: String?
    let model: String?
    let exposure: String?
    let aperture: String?
    let focalLength: String?
    let iso: Int?

    enum CodingKeys: String, CodingKey {
        case make
        case model
        case exposure = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
}

enum ExifRow {
    case make(String)
    case model(String)
    case exposure(String)
    case aperture(String)
    case focalLength(String)
    case iso(String)

    var title: String {
        switch self {
        case .make:
            return "Make"
        case .model:
            return "Model"
        case .exposure:
            return "Exposure"
        case .aperture:
            return "Aperture"
        case .focalLength:
            return "Focal Length"
        case .iso:
            return "ISO"
        }
    }

    var value: String {
        switch self {
        case let .make(make):
            return make
        case let .model(model):
            return model
        case let .exposure(exposure):
            return "\(exposure) s"
        case let .aperture(aperture):
            return "f/\(aperture)"
        case let .focalLength(focalLength):
            return "\(focalLength) mm"
        case let .iso(iso):
            return iso
        }
    }
}

extension Exif {
    var rows: [ExifRow] {
        var newRows = [ExifRow]()

        if let make = make {
            newRows.append(.make(make))
        }

        if let model = model {
            newRows.append(.model(model))
        }

        if let exposure = exposure {
            newRows.append(.exposure(exposure))
        }

        if let aperture = aperture {
            newRows.append(.aperture(aperture))
        }

        if let focalLength = focalLength {
            newRows.append(.focalLength(focalLength))
        }

        if let iso = iso {
            newRows.append(.iso("\(iso)"))
        }

        return newRows
    }
}
