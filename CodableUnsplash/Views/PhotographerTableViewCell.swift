//
//  PhotoDetailPhotographerTableViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotographerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.masksToBounds = true
    }

    func configure(with user: User) {
        profileImageView.kf.setImage(with: user.profileImage.medium)
        nameLabel.text = user.name
        if let twitterHandle = user.twitterUsername {
            twitterHandleLabel.text = "@\(twitterHandle)"
        }
        twitterHandleLabel.isHidden = user.twitterUsername == nil
    }
}
