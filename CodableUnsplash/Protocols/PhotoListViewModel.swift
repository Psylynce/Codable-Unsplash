//
//  PhotoListViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotoListViewModel {
    var title: String { get }
    var photos: Variable<[Photo]> { get set }

    func fetchPhotos()
}
