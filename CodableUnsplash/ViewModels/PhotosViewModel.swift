//
//  PhotosViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/21/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

final class PhotosViewModel {

    var photos = Variable<[Photo]>([])

    private let photoService = PhotoService()

    func fetchPhotos() {
        photoService.listPhotos { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(photos):
                strongSelf.photos.value = photos
            case .failure:
                print("Failed")
            }
        }
    }

}
