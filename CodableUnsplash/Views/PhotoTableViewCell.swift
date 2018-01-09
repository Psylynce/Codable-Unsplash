//
//  PhotoTableViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!

    func configure(with photo: Photo) {
        photoImageView.kf.setImage(with: photo.urls.regular)
    }
}
