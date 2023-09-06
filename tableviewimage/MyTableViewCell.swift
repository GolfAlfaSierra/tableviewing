//
//  MyTableViewCell.swift
//  tableviewimage
//
//  Created by artyom s on 06.09.2023.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func didUpdateImage(_ cell: MyTableViewCell)
}

final class MyTableViewCell: UITableViewCell {
    
    weak var delegate: MyTableViewCellDelegate! = nil
    
    @IBOutlet var myImageView: UIImageView! {
        didSet {
            myImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    
    static let CELL_ID = String(describing: MyTableViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: MyTableViewCell.CELL_ID, bundle: nil)
    }
    
    func loadImage(_ urlString: String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {d,r,e in
            
        }
        task.resume()
        
    }
    
    func configure(_ image: UIImage? = nil) {
        
        
        if myImageView.image == nil {
            activityIndicator.startAnimating()
        } else {
            myImageView.image = image
            delegate?.didUpdateImage(self)
            activityIndicator.stopAnimating()
        }
    }
    
}
