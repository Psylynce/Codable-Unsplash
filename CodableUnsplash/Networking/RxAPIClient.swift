//
//  RxAPIClient.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/29/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

final class RxAPIClient {

    func send<T: Codable>(endpoint: APIEndpoint) -> Observable<T> {
        return Observable<T>.create { observer in
            let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
                do {
                    let model: T = try JSONDecoder.decoder.decode(T.self, from: data)
                    observer.onNext(model)
                } catch {
                    observer.onError(error)
                }

                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
