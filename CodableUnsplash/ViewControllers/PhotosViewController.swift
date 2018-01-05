//
//  ViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotosViewController: UIViewController {

    private let photoService = PhotoService()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()

        photoService.listPhotos { result in
            switch result {
            case let .success(photos):
                let names = photos.map { $0.user.name }
                print("""
Got the list of photos!

\(names.joined(separator: "\n"))
""")
            case .failure:
                print("Failed")
            }
        }
    }

    private func setupAppearance() {
        navigationItem.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
