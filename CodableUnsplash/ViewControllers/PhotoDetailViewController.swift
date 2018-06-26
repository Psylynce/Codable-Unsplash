//
//  PhotoDetailViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol PhotoDetailViewControllerDelegate: class {
    func showUser(_ user: User)
}

final class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: PhotoDetailViewControllerDelegate?

    var viewModel: PhotoDetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        viewModel.fetchPhoto()

        viewModel.sections.asObservable()
        .bind(to: tableView.rx.items(dataSource: PhotoDetailViewController.dataSource()))
        .disposed(by: disposeBag)
    }

    private func setupAppearance() {
        navigationItem.largeTitleDisplayMode = .never

        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none

        tableView.register(TableSectionHeader.nib(), forHeaderFooterViewReuseIdentifier: TableSectionHeader.reuseIdentifier)
    }
}

extension PhotoDetailViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<PhotoDetailViewModel.Section> {
        return RxTableViewSectionedReloadDataSource<PhotoDetailViewModel.Section>(configureCell: { (dataSource, tableView, indexPath, sectionItem) -> UITableViewCell in
            switch dataSource[indexPath] {
            case let .photo(photo):
                let cell: PhotoTableViewCell = tableView.dequeueCell(for: indexPath)
                cell.configure(with: photo)

                return cell
            case let .photographer(user):
                let cell: PhotographerTableViewCell = tableView.dequeueCell(for: indexPath)
                cell.configure(with: user)

                return cell
            case let .location(row), let .exif(row):
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                cell.textLabel?.text = row.title
                cell.textLabel?.textColor = Colors.gray333
                cell.detailTextLabel?.text = row.value

                return cell
            }
        })
    }
}

extension PhotoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.sections.value[indexPath.section] {
        case let .photographer(items):
            let sectionItem = items[indexPath.row]
            if case let .photographer(user) = sectionItem {
                delegate?.showUser(user)
            }
        default:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.sections.value[indexPath.section]

        switch section {
        case let .photo(items):
            let sectionItem = items[indexPath.row]
            guard case let .photo(photo) = sectionItem else { return 0 }

            let height = (tableView.bounds.width * CGFloat(photo.height)) / CGFloat(photo.width)
            return height
        default:
            return UITableViewAutomaticDimension
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections.value[section].title == nil ? 0 : 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = viewModel.sections.value[section].title

        if title == nil {
            return nil
        }

        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeader.reuseIdentifier) as! TableSectionHeader
        view.titleLabel.text = title

        return view
    }
}
