//
//  Service.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

struct ServiceQueue {
    static let queue = OperationQueue()

    static let serialQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class Service {
    typealias ServiceCompletion<T> = ((Result<T>) -> Void)

    let queue: OperationQueue

    init(queue: OperationQueue = ServiceQueue.queue) {
        self.queue = queue
    }
}

protocol ServiceNotification: RawRepresentable where RawValue == String {
    var notification: Notification { get }
}

extension ServiceNotification {
    var notificationName: Notification.Name {
        return Notification.Name(rawValue: self.rawValue)
    }

    var notification: Notification {
        return Notification(name: notificationName)
    }
}
