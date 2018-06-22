//
//  CollectionsService.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class CollectionsService: Service {
    func fetchFeaturedCollections(page: Int = 1, completion: ServiceCompletion<[PhotoCollection]>?) {
        let endpoint = CollectionsEndpoints.featuredCollections(page: page)
        let operation = APIRequestOperation<[PhotoCollection]>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }

    func fetchCollectionPhotos(id: Int, page: Int = 1, completion: ServiceCompletion<[Photo]>?) {
        let endpoint = CollectionsEndpoints.fetchCollectionPhotos(id: id, page: page)
        let operation = APIRequestOperation<[Photo]>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }
}
