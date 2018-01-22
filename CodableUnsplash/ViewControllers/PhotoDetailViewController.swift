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
        case location(Location)
        case exif(Exif)

        var title: String? {
            switch self {
            case .location:
                return "Location"
            case .exif:
                return "Camera Information"
            default:
                return nil
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!

    private var sections = [Section]()
    private var photo: Photo?
    private let photoService = PhotoService()

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

        if let location = photo.location {
            sections.append(.location(location))
        }

        if let exif = photo.exif, exif.rows.isEmpty == false {
            sections.append(.exif(exif))
        }
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
        switch sections[section] {
        case let .location(location):
            return location.rows.count
        case let .exif(exif):
            return exif.rows.count
        default:
            return 1
        }
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
        case let .location(location):
            let locationCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let exifRow = location.rows[indexPath.row]
            locationCell.textLabel?.text = exifRow.title
            locationCell.detailTextLabel?.text = exifRow.value

            cell = locationCell
        case let .exif(exif):
            let exifCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let exifRow = exif.rows[indexPath.row]
            exifCell.textLabel?.text = exifRow.title
            exifCell.detailTextLabel?.text = exifRow.value

            cell = exifCell
        }

        return cell
    }
}

extension PhotoDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case let .photographer(user):
            let vc = Storyboard.main.instantiate(viewController: UserProfileViewController.self)
            vc.user = user
            show(vc, sender: self)
        default:
            return
        }
    }

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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}
