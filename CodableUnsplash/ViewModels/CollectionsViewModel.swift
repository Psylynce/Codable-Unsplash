//
//  CollectionsViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

final class CollectionsViewModel {

    var collections = Variable<[Collection]>([])
    private let collectionsService = CollectionsService()

    func fetchFeaturedCollections(page: Int = 1) {
        collectionsService.fetchFeaturedCollections(page: page) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(collections):
                strongSelf.collections.value = collections
            case .failure:
                return
            }
        }
    }
}
