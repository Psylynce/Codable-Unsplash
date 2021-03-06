//
//  UITableView+Extensions.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 2/12/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueCell<T: ReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell for reuse identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}
