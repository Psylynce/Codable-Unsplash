//
//  UserProfileViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/11/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = user?.name
    }
}
