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

        rootNavigationController.pushViewController(viewController, animated: false)
    }
}
