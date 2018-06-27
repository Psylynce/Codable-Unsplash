//
//  SearchViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/27/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var viewModel: SearchViewModel!
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
