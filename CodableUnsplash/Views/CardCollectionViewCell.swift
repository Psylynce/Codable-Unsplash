//
//  CardCollectionViewCell.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    let gradientLayer: CAGradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 5

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false

        contentView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = layer.bounds
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }

    func addGradient(toView view: UIView) {
        gradientLayer.colors = [UIColor(white: 0.0, alpha: 0.4).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        view.layer.addSublayer(gradientLayer)
        view.layer.masksToBounds = true
    }
}
