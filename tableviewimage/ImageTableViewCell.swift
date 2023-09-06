//
//  ImageTableViewCell.swift
//  tableviewimage
//
//  Created by artyom s on 06.09.2023.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet var mImageView: UIImageView! {
        didSet {
            mImageView.contentMode = .scaleAspectFit
        }
    }
    
    static let CELL_ID = String(describing: ImageTableViewCell.self)
    
    static let nib: UINib = {
        return UINib(nibName: ImageTableViewCell.CELL_ID, bundle: nil)
    }()
    
    func updateState(image: UIImage?) {
        mImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mImageView.image = nil
    }
}
