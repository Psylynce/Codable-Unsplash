//
//  PhotoDetailViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/25/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

final class PhotoDetailViewModel {

    enum Section {
        case photo(items: [SectionItem])
        case photographer(items: [SectionItem])
        case location(items: [SectionItem])
        case exif(items: [SectionItem])
    }

    enum SectionItem {
        case photo(Photo)
        case photographer(User)
        case location(TitleValueRow)
        case exif(TitleValueRow)
    }

    var sections = Variable<[Section]>([])
    var photo: Photo

    private let photoService = PhotoService()

    init(photo: Photo) {
        self.photo = photo

        sections.value = [
            .photo(items: [.photo(photo)]),
            .photographer(items: [.photographer(photo.user)])
        ]
    }

    func fetchPhoto() {
        photoService.fetchPhoto(id: photo.id) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(photo):
                strongSelf.photo = photo
                strongSelf.buildSections()
            case .failure:
                return
            }
        }
    }

    private func buildSections() {
        if let location = photo.location {
            let items = location.rows.map { SectionItem.location($0) }
            sections.value.append(.location(items: items))
        }

        if let exif = photo.exif, exif.rows.isEmpty == false {
            let items = exif.rows.map { SectionItem.exif($0) }
            sections.value.append(.exif(items: items))
        }
    }
}

extension PhotoDetailViewModel.Section: SectionModelType {
    typealias Item = PhotoDetailViewModel.SectionItem

    init(original: PhotoDetailViewModel.Section, items: [PhotoDetailViewModel.SectionItem]) {
        switch original {
        case .photo(items: _):
            self = .photo(items: items)
        case .photographer(items: _):
            self = .photographer(items: items)
        case .location(items: _):
            self = .location(items: items)
        case .exif(items: _):
            self = .exif(items: items)
        }
    }

    var items: [PhotoDetailViewModel.SectionItem] {
        switch self {
        case let .photo(items):
            return items.map { $0 }
        case let .photographer(items):
            return items.map { $0 }
        case let .location(items):
            return items.map { $0 }
        case let .exif(items):
            return items.map { $0 }
        }
    }

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
