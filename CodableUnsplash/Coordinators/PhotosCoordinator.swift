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

    convenience init(parent: Coordinator, viewModel: PhotoListViewModel) {
        self.init(rootNavigationController: parent.rootNavigationController, viewModel: viewModel)

        self.parentCoordinator = parent
        self.parentCoordinator?.childCoordinators.append(self)
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

        if animated == false {
            let searchViewModel = PhotoSearchViewModel(placeholder: "Search Photos")
            let searchViewController = Storyboard.search.instantiate(viewController: SearchViewController.self)
            searchViewController.viewModel = searchViewModel
            let searchController = UISearchController(searchResultsController: searchViewController)
            searchController.searchResultsUpdater = searchViewController
            searchController.searchBar.placeholder = searchViewModel.placeholder

            photosViewController.searchController = searchController
        }

        rootNavigationController.pushViewController(photosViewController, animated: animated)
    }
}

extension PhotosCoordinator: PhotosViewControllerDelegate {
    func showPhoto(_ photo: Photo) {
        let viewController = Storyboard.photos.instantiate(viewController: PhotoDetailViewController.self)
        viewController.delegate = self
        viewController.viewModel = PhotoDetailViewModel(photo: photo)
        rootNavigationController.show(viewController, sender: rootNavigationController)
    }

    func finishedFlow() {
        complete()
    }
}

extension PhotosCoordinator: PhotoDetailViewControllerDelegate {
    func showUser(_ user: User) {
        let coordinator = UserProfileCoordinator(rootNavigationController: rootNavigationController, user: user)
        coordinator.start()
    }
}
