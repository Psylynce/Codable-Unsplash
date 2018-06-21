//
//  PhotosCoordinator.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/21/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation

final class PhotosCoordinator: Coordinator {

    override func start() {
        embedPhotosViewController()
    }

    private func embedPhotosViewController() {
        let photosViewController = Storyboard.photos.instantiate(viewController: PhotosViewController.self)
        photosViewController.delegate = self
        rootNavigationController.pushViewController(photosViewController, animated: false)
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
