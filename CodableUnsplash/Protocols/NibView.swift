//
//  NibView.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/26/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

protocol NibView {}

extension NibView where Self: UIView {
    static func nib(bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: String(describing: self), bundle: bundle)
    }
}
