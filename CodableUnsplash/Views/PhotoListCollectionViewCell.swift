//
//  PhotoListCollectionViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit
import Kingfisher

final class PhotoListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photographerImageView: UIImageView!
    @IBOutlet weak var photographerNameLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        let width = UIScreen.main.bounds.width - (2 * 20)
        widthConstraint.constant = width

        photoImageView.contentMode = .scaleAspectFill
        photographerImageView.contentMode = .scaleAspectFit
        photographerImageView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        photographerImageView.layer.cornerRadius = photographerImageView.bounds.width / 2
    }

    func configure(with photo: Photo) {
        photoImageView.backgroundColor = UIColor(hex: photo.color)
        photoImageView.kf.setImage(with: photo.urls.regular)
        photographerImageView.kf.setImage(with: photo.user.profileImage.medium)
        photographerNameLabel.text = photo.user.name

        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: CGFloat(photo.height) / CGFloat(photo.width)).isActive = true
    }
}
