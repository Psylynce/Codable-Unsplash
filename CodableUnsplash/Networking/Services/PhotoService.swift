//
//  PhotoService.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class PhotoService: Service {

    func fetchPhotos(with endpoint: APIEndpoint, completion: ServiceCompletion<[Photo]>?) {
        let operation = APIRequestOperation<[Photo]>(endpoint: endpoint, completion: completion)
        queue.addOperation(operation)
    }

    func listPhotos(completion: ServiceCompletion<[Photo]>?) {
        let endpoint = PhotoEndpoint.listPhotos
        fetchPhotos(with: endpoint, completion: completion)
    }

    func fetchPhoto(id: String, completion: ServiceCompletion<Photo>?) {
        let endpoint = PhotoEndpoint.fetchPhoto(id: id)
        let operation = APIRequestOperation<Photo>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }

    func searchPhotos(query: String, page: Int = 1, completion: ServiceCompletion<SearchResults<Photo>>?) {
        let endpoint = PhotoEndpoint.searchPhotos(query: query, page: page)
        let operation = APIRequestOperation<SearchResults<Photo>>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }
}
