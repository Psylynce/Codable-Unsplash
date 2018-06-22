//
//  TabBarController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/21/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    let photosCoordinator: PhotosCoordinator
    let collectionsCoordinator: CollectionsCoordinator

    init() {
        let photosNavigationController = UINavigationController()
        photosNavigationController.tabBarItem = UITabBarItem(title: "Photos", image: nil, selectedImage: nil)
        photosCoordinator = PhotosCoordinator(rootNavigationController: photosNavigationController)
        photosCoordinator.start()

        let collectionsNavigationController = UINavigationController()
        collectionsNavigationController.tabBarItem = UITabBarItem(title: "Collections", image: nil, selectedImage: nil)
        collectionsCoordinator = CollectionsCoordinator(rootNavigationController: collectionsNavigationController)
        collectionsCoordinator.start()

        super.init(nibName: nil, bundle: nil)

        setViewControllers([photosNavigationController, collectionsNavigationController], animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
