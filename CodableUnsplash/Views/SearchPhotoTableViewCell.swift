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
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.layer.shadowRadius = 2
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowOpacity = 0.2
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 3)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        let color: UIColor = highlighted ? UIColor.white.withAlphaComponent(0.75) : .white
        nameLabel.textColor = color

        let overlayColor: UIColor = highlighted ? UIColor.black.withAlphaComponent(0.1) : .clear
        overlayView.backgroundColor = overlayColor
    }

    func configure(with photo: Photo) {
        photoImageView.kf.setImage(with: photo.urls.regular, options: [.transition(.fade(0.3))])
        photoImageView.backgroundColor = photo.backgroundColor
        nameLabel.text = photo.user.name
    }
}
