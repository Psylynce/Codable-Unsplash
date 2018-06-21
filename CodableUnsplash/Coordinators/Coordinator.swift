//
//  Coordinator.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/21/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

class Coordinator: NSObject {

    let rootNavigationController: UINavigationController

    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        super.init()
    }

    convenience init(parent: Coordinator) {
        self.init(rootNavigationController: parent.rootNavigationController)

        self.parentCoordinator = parent
        self.parentCoordinator?.childCoordinators.append(self)
    }

    func start() {
        assertionFailure("Coordinator subclass needs to override start().")
    }

    func childCoordinatorDidFinish(_ coordinator: Coordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    func complete() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
}
