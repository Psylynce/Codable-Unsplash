//
//  PhotosCoordinator.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/21/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotosCoordinator: Coordinator {

    let viewModel: PhotoListViewModel

    init(rootNavigationController: UINavigationController, viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        super.init(rootNavigationController: rootNavigationController)
    }

    override func start() {
        if viewModel is PhotosViewModel {
            showPhotosViewController(animated: false)
        } else if viewModel is CollectionPhotosViewModel {
            showPhotosViewController(animated: true)
        }
    }

    private func showPhotosViewController(animated: Bool) {
        let photosViewController = Storyboard.photos.instantiate(viewController: PhotosViewController.self)
        photosViewController.delegate = self
        photosViewController.viewModel = viewModel
        rootNavigationController.pushViewController(photosViewController, animated: animated)
    }
}

extension PhotosCoordinator: PhotosViewControllerDelegate {
    func showPhoto(_ photo: Photo) {
        let viewController = Storyboard.photos.instantiate(viewController: PhotoDetailViewController.self)
        viewController.delegate = self
        viewController.configure(with: photo)
        rootNavigationController.show(viewController, sender: rootNavigationController)
    }
}

extension PhotosCoordinator: PhotoDetailViewControllerDelegate {
    func showUser(_ user: User) {
        let coordinator = UserProfileCoordinator(rootNavigationController: rootNavigationController, user: user)
        coordinator.start()
    }
}
