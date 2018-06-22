//
//  ViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/5/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PhotosViewControllerDelegate: class {
    func showPhoto(_ photo: Photo)
    func finishedFlow()
}

final class PhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    weak var delegate: PhotosViewControllerDelegate?

    var viewModel: PhotoListViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        viewModel.fetchPhotos()

        viewModel.photos.asObservable()
        .bind(to: collectionView.rx.items(cellIdentifier: PhotoListCollectionViewCell.reuseIdentifier, cellType: PhotoListCollectionViewCell.self)) { _, photo, cell in
            cell.configure(with: photo)
        }.disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParentViewController {
            delegate?.finishedFlow()
        }
    }

    private func setupAppearance() {
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.delegate = self
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showPhoto(viewModel.photos.value[indexPath.item])
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
