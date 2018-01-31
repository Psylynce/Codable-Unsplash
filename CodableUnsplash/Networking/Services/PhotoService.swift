//
//  PhotoService.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class PhotoService: Service {

    func listPhotos(completion: ServiceCompletion<[Photo]>?) {
        let endpoint = PhotoEndpoint.listPhotos
        let operation = APIRequestOperation<[Photo]>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }

    func fetchPhoto(id: String, completion: ServiceCompletion<Photo>?) {
        let endpoint = PhotoEndpoint.fetchPhoto(id: id)
        let operation = APIRequestOperation<Photo>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }
}
