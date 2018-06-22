//
//  CollectionPhotosViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

final class CollectionPhotosViewModel: PhotoListViewModel {

    var title: String { return collection.title }
    var photos = Variable<[Photo]>([])

    private let collection: PhotoCollection
    private let photoService = PhotoService()

    init(collection: PhotoCollection) {
        self.collection = collection
    }

    func fetchPhotos() {
        let endpoint = CollectionsEndpoints.fetchCollectionPhotos(id: collection.id, page: 1)
        photoService.fetchPhotos(with: endpoint) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(photos):
                strongSelf.photos.value = photos
            case .failure:
                return
            }
        }
    }
}
