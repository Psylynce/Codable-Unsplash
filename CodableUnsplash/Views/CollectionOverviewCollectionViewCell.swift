//
//  CollectionOverviewCollectionViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/22/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class CollectionOverviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var collectionAuthorLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        coverImageView.round(corners: [.topLeft, .topRight])
        leftImageView.round(corners: .bottomLeft)
        rightImageView.round(corners: .bottomRight)
    }

    func configure(with collection: Collection) {
        for i in 0 ..< 3 {
            let photoURL = collection.previewPhotos[i].urls.regular

            if i == 0 {
                setImage(to: coverImageView, with: photoURL)
            } else if i == 1 {
                setImage(to: leftImageView, with: photoURL)
            } else if i == 2 {
                setImage(to: rightImageView, with: photoURL)
            }
        }

        collectionTitleLabel.text = collection.title
        collectionAuthorLabel.text = "by \(collection.user.name)"
    }

    private func setImage(to imageView: UIImageView, with url: URL) {
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.3))])
    }
}
