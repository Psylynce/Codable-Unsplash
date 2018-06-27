//
//  PhotoSearchViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/27/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

final class PhotoSearchViewModel: SearchViewModel {

    private let photoService = PhotoService()

    var photos = Variable<[Photo]>([])

    override func searchQuery() {
        photoService.searchPhotos(query: query.value, page: 1) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(searchResults):
                strongSelf.photos.value = searchResults.results
            case .failure:
                return
            }
        }
    }
}
