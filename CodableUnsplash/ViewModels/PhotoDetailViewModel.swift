//
//  PhotoDetailViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/25/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class PhotoDetailViewModel {

    enum Section {
        case photo(Photo)
        case photographer(User)
        case location(Location)
        case exif(Exif)

        var title: String? {
            switch self {
            case .location:
                return "Location"
            case .exif:
                return "Camera Information"
            default:
                return nil
            }
        }
    }

    var sections = [Section]()
    var photo: Photo

    private let photoService = PhotoService()

    init(photo: Photo) {
        self.photo = photo
    }

    func fetchPhoto(completion: (() -> Void)?) {
        photoService.fetchPhoto(id: photo.id) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(photo):
                strongSelf.photo = photo
                strongSelf.buildSections()
                completion?()
            case .failure:
                return
            }
        }
    }

    private func buildSections() {
        sections = [.photo(photo), .photographer(photo.user)]

        if let location = photo.location {
            sections.append(.location(location))
        }

        if let exif = photo.exif, exif.rows.isEmpty == false {
            sections.append(.exif(exif))
        }
    }
}
