//
//  ImageTableViewCell.swift
//  tableviewimage
//
//  Created by artyom s on 06.09.2023.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    let imageLoader: ImageLoaderProtocol = ImageLoader()

    @IBOutlet var mImageView: UIImageView! {
        didSet {
            mImageView.contentMode = .scaleAspectFit
        }
    }

    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
        }
    }

    static let CELL_ID = String(describing: ImageTableViewCell.self)

    static let nib: UINib = {
        UINib(nibName: ImageTableViewCell.CELL_ID, bundle: nil)
    }()

    func updateState(image: UIImage?) {
        mImageView.image = image

        activityIndicator.stopAnimating()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mImageView.image = nil
        activityIndicator.startAnimating()
    }
}
