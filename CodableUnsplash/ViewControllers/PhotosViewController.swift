//
//  ViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }

    private func setupAppearance() {
        navigationItem.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
