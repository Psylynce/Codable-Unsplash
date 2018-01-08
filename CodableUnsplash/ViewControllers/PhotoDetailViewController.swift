//
//  PhotoDetailViewController.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 1/8/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!

    private var photo: Photo?
    private let photoService = PhotoService()

    class var viewController: PhotoDetailViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! PhotoDetailViewController

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        updateView()

        if let photo = photo {
            photoService.fetchPhoto(id: photo.id, completion: { [weak self] result in
                guard let strongSelf = self else { return }

                switch result {
                case let .success(photo):
                    strongSelf.photo = photo
                    strongSelf.updateView()
                case .failure:
                    print("Failed detail fetch")
                }
            })
        }
    }

    func configure(with photo: Photo) {
        self.photo = photo
    }

    private func setupAppearance() {
        navigationItem.largeTitleDisplayMode = .never
    }

    private func updateView() {
        guard let photo = photo else { return }

        let height = (imageView.bounds.width * CGFloat(photo.height)) / CGFloat(photo.width)
        imageViewHeightConstraint.constant = height
        imageView.kf.setImage(with: photo.urls.regular)
    }
}
