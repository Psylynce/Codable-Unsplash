//
//  SearchPhotoTableViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/27/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit
import RxSwift

final class SearchPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(with photo: Photo) {
        photoImageView.kf.setImage(with: photo.urls.regular, options: [.transition(.fade(0.3))])
        nameLabel.text = photo.user.name
    }
}
