//
//  CollectionsCoordinator.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class CollectionsCoordinator: Coordinator {

    override func start() {
        embedCollectionsViewController()
    }

    private func embedCollectionsViewController() {
        let viewController = Storyboard.collections.instantiate(viewController: CollectionsViewController.self)
        viewController.delegate = self
        rootNavigationController.pushViewController(viewController, animated: false)
    }
}

extension CollectionsCoordinator: CollectionsViewControllerDelegate {
    func showCollection(_ collection: PhotoCollection) {
        let viewModel = CollectionPhotosViewModel(collection: collection)
        let coordinator = PhotosCoordinator(parent: self, viewModel: viewModel)
        coordinator.start()
    }
}
