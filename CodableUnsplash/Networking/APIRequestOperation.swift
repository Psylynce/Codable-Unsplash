//
//  APIRequestOperation.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class APIRequestOperation<Model: Decodable>: Operation {

    typealias NetworkCompletion = ((Result<Model>) -> Void)
    override var isAsynchronous: Bool { return true }

    let endpoint: APIEndpoint

    var data: Data?
    var model: Model?
    var error: Error?

    private let decoder: JSONDecoder
    private var task: URLSessionDataTask?
    private var completion: NetworkCompletion?

    init(endpoint: APIEndpoint, decoder: JSONDecoder = JSONDecoder(), completion: NetworkCompletion? = nil) {
        self.endpoint = endpoint
        self.decoder = decoder
        self.completion = completion
        super.init()
        qualityOfService = .userInitiated
    }

    override func main() {
        guard isCancelled == false else {
            isFinished = true
            return
        }

        task = URLSession.shared.dataTask(with: endpoint.request()) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }

            guard strongSelf.isCancelled == false else {
                strongSelf.isFinished = true
                return
            }

            if let error = error {
                strongSelf.error = error
                DispatchQueue.main.async {
                    strongSelf.completion?(.failure(error))
                }
                print("NetworkOperation Network Error: \(error)")
                strongSelf.isFinished = true
                return
            }

            strongSelf.data = data
            do {
                let model = try strongSelf.decoder.decode(Model.self, from: data)
                strongSelf.model = model
                DispatchQueue.main.async {
                    strongSelf.completion?(.success(model))
                }
            } catch {
                print("""
                    Error decoding \(Model.self): \(error)

                    Operation Endpoint: \(strongSelf.endpoint)
                    """)
                DispatchQueue.main.async {
                    strongSelf.completion?(.failure(error))
                }
            }

            strongSelf.isFinished = true
        }

        task?.resume()
    }

    override func cancel() {
        task?.cancel()
    }
}
