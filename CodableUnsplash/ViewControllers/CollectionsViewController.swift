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

final class CollectionsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
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
