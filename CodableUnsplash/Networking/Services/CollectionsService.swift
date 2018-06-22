//
//  CollectionsService.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class CollectionsService: Service {
    func fetchFeaturedCollections(page: Int = 1, completion: ServiceCompletion<[Collection]>?) {
        let endpoint = CollectionsEndpoints.featuredCollections(page: page)
        let operation = APIRequestOperation<[Collection]>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }
}
