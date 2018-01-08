//
//  ViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let photoService = PhotoService()
    private var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()

        photoService.listPhotos { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case let .success(photos):
                let names = photos.map { $0.user.name }
                print("""
Got the list of photos!

\(names.joined(separator: "\n"))
""")
                strongSelf.photos = photos
                strongSelf.collectionView.reloadData()
            case .failure:
                print("Failed")
            }
        }
    }

    private func setupAppearance() {
        navigationItem.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.dataSource = self
        collectionView.delegate = self

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoListCollectionViewCell
        let photo = photos[indexPath.item]
        cell.configure(with: photo)

        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
}
