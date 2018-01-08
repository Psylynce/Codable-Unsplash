//
//  ReusableView.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

protocol ReusableView {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}
