//
//  UserProfileCoordinator.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/21/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class UserProfileCoordinator: Coordinator {

    private let user: User

    init(rootNavigationController: UINavigationController, user: User) {
        self.user = user

        super.init(rootNavigationController: rootNavigationController)
    }

    override func start() {
        showProfile()
    }

    private func showProfile() {
        let viewController = Storyboard.photos.instantiate(viewController: UserProfileViewController.self)
        viewController.user = user
        rootNavigationController.show(viewController, sender: self)
    }
}
