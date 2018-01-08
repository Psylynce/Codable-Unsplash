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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        let vc = PhotoDetailViewController.viewController
        vc.configure(with: photo)
        show(vc, sender: self)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (2 * 20)
        return CGSize(width: width, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
