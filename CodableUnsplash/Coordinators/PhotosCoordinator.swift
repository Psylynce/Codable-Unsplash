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
        let photosViewController = Storyboard.main.instantiate(viewController: PhotosViewController.self)
        rootNavigationController.pushViewController(photosViewController, animated: false)
    }

    private func showPhotoDetails() {

    }
}
