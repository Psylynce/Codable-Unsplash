//
//  PhotoService.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class PhotoService: Service {

    override init(queue: OperationQueue = ServiceQueue.queue) {
        super.init(queue: queue)
    }

    func listPhotos(completion: ServiceCompletion<[Photo]>?) {
        let endpoint = PhotoEndpoint.listPhotos
        let operation = APIRequestOperation<[Photo]>(endpoint: endpoint, completion: completion)

        queue.addOperation(operation)
    }
}
