//
//  Result.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
