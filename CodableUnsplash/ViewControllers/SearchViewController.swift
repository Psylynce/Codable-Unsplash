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

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.query.asObservable()
        .debounce(0.3, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .subscribe(onNext: { [viewModel] _ in
            viewModel?.searchQuery()
        }).disposed(by: disposeBag)

        if let photosViewModel = viewModel as? PhotoSearchViewModel {
            photosViewModel.photos.asObservable()
                .bind(to: tableView.rx.items(cellIdentifier: SearchPhotoTableViewCell.reuseIdentifier, cellType: SearchPhotoTableViewCell.self)) { _, photo, cell in
                cell.configure(with: photo)
            }.disposed(by: disposeBag)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.query.value = text
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
