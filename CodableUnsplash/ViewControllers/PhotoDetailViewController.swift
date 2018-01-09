//
//  PhotoDetailViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotoDetailViewController: UIViewController {

    enum Section {
        case photo(Photo)
        case photographer(User)

        var title: String? {
            return nil
        }
    }

    @IBOutlet weak var tableView: UITableView!

    private var sections = [Section]()
    private var photo: Photo?
    private let photoService = PhotoService()

    class var viewController: PhotoDetailViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! PhotoDetailViewController

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()

        if let photo = photo {
            photoService.fetchPhoto(id: photo.id, completion: { [weak self] result in
                guard let strongSelf = self else { return }

                switch result {
                case let .success(photo):
                    strongSelf.configure(with: photo)
                    strongSelf.tableView.reloadData()
                case .failure:
                    print("Failed detail fetch")
                }
            })
        }
    }

    func configure(with photo: Photo) {
        self.photo = photo

        sections = [.photo(photo), .photographer(photo.user)]
    }

    private func setupAppearance() {
        navigationItem.largeTitleDisplayMode = .never

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }
}

extension PhotoDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Update when we have more sections for exif and location and more info
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]

        var cell: UITableViewCell
        switch section {
        case let .photo(photo):
            let photoCell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.reuseIdentifier, for: indexPath) as! PhotoTableViewCell
            photoCell.configure(with: photo)

            cell = photoCell
        case let .photographer(user):
            let photographerCell = tableView.dequeueReusableCell(withIdentifier: PhotographerTableViewCell.reuseIdentifier, for: indexPath) as! PhotographerTableViewCell
            photographerCell.configure(with: user)

            cell = photographerCell
        }

        return cell
    }
}

extension PhotoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]

        switch section {
        case let .photo(photo):
            let height = (tableView.bounds.width * CGFloat(photo.height)) / CGFloat(photo.width)
            return height
        default:
            return UITableViewAutomaticDimension
        }
    }
}
