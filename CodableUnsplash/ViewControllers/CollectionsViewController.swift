//
//  CollectionsViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class CollectionsViewController: UIViewController {

    private let viewModel = CollectionsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchFeaturedCollections()
    }
}
