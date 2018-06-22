//
//  CollectionsViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CollectionsViewControllerDelegate: class {
    func showCollection(_ collection: PhotoCollection)
}

final class CollectionsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!

    weak var delegate: CollectionsViewControllerDelegate?
    
    private let viewModel = CollectionsViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        viewModel.fetchFeaturedCollections()
        viewModel.collections.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: CollectionOverviewCollectionViewCell.reuseIdentifier, cellType: CollectionOverviewCollectionViewCell.self)) { _, collection, cell in
                cell.configure(with: collection)
            }.disposed(by: disposeBag)
    }

    private func setupAppearance() {
        navigationItem.title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.delegate = self
    }
}

extension CollectionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showCollection(viewModel.collections.value[indexPath.item])
    }
}

extension CollectionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (2 * 20)
        return CGSize(width: width, height: 360)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
