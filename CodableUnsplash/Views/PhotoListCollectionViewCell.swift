//
//  PhotoListCollectionViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotoListCollectionViewCell: CardCollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photographerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        photoImageView.contentMode = .scaleAspectFill
        addGradient(toView: photoImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        photoImageView.layer.cornerRadius = 5
    }

    func configure(with photo: Photo) {
        photoImageView.backgroundColor = photo.backgroundColor
        photoImageView.kf.setImage(with: photo.urls.regular, options: [.transition(.fade(0.3))])
        photographerNameLabel.text = photo.user.name
    }
}
