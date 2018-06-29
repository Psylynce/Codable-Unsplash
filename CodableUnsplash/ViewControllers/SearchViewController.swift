//
//  SearchViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/27/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var viewModel: SearchViewModel!

    private let apiClient = RxAPIClient()
    private let disposeBag = DisposeBag()
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.rx.text.asObservable()
        .debounce(0.3, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .map { ($0 ?? "") }
        .map { PhotoEndpoint.searchPhotos(query: $0) }
        .flatMap { endpoint -> Observable<SearchResults<Photo>> in
            return self.apiClient.send(endpoint: endpoint)
        }
        .map { $0.results }
        .bind(to: tableView.rx.items(cellIdentifier: SearchPhotoTableViewCell.reuseIdentifier, cellType: SearchPhotoTableViewCell.self)) { _, photo, cell in
            cell.configure(with: photo)
        }
        .disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
