//
//  PhotoDetailViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerDelegate: class {
    func showUser(_ user: User)
}

final class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: PhotoDetailViewControllerDelegate?

    var viewModel: PhotoDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        viewModel.fetchPhoto { [weak tableView] in
            tableView?.reloadData()
        }
    }

    private func setupAppearance() {
        navigationItem.largeTitleDisplayMode = .never

        let nib = UINib(nibName: "TableSectionHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: TableSectionHeader.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }
}

extension PhotoDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case let .location(location):
            return location.rows.count
        case let .exif(exif):
            return exif.rows.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]

        var cell: UITableViewCell
        switch section {
        case let .photo(photo):
            let photoCell: PhotoTableViewCell = tableView.dequeueCell(for: indexPath)
            photoCell.configure(with: photo)

            cell = photoCell
        case let .photographer(user):
            let photographerCell: PhotographerTableViewCell = tableView.dequeueCell(for: indexPath)
            photographerCell.configure(with: user)

            cell = photographerCell
        case let .location(location):
            let locationCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let row = location.rows[indexPath.row]
            locationCell.textLabel?.text = row.title
            locationCell.textLabel?.textColor = Colors.gray333
            locationCell.detailTextLabel?.text = row.value

            cell = locationCell
        case let .exif(exif):
            let exifCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let row = exif.rows[indexPath.row]
            exifCell.textLabel?.text = row.title
            exifCell.textLabel?.textColor = Colors.gray333
            exifCell.detailTextLabel?.text = row.value

            cell = exifCell
        }

        return cell
    }
}

extension PhotoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section] {
        case let .photographer(user):
            delegate?.showUser(user)
        default:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.sections[indexPath.section]

        switch section {
        case let .photo(photo):
            let height = (tableView.bounds.width * CGFloat(photo.height)) / CGFloat(photo.width)
            return height
        default:
            return UITableViewAutomaticDimension
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections[section].title == nil ? 0 : 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = viewModel.sections[section].title

        if title == nil {
            return nil
        }

        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeader.reuseIdentifier) as! TableSectionHeader
        view.titleLabel.text = title

        return view
    }
}
