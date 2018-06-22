//
//  Storyboard.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/12/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit


enum Storyboard: String {
    case collections
    case photos

    func instantiate<T: StoryboardViewController>(viewController: T.Type) -> T {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: nil).instantiateViewController(withIdentifier: viewController.storyboardIdentifier) as! T
    }
}

protocol StoryboardViewController {
    static var storyboardIdentifier: String { get }
}

extension StoryboardViewController {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension UIViewController: StoryboardViewController {}
