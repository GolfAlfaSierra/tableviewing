//
//  ImageLoader.swift
//  tableviewimage
//
//  Created by artyom s on 06.09.2023.
//

import UIKit.UIImage

final class ImageLoader: ImageLoaderProtocol {
    private static let imageCache = NSCache<NSString, UIImage>()
    private static var runningRequests = Set<String>()

    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else {
            print("cannot convert \(urlString) to URL")
            return
        }

        if let cachedImage = Self.imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
        }

        if Self.runningRequests.contains(urlString) {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            Self.runningRequests.remove(urlString)
            guard let data, let image = UIImage(data: data) else {
                print("image decode error")
                return
            }

            Self.imageCache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {
                completion(image)
            }
        }

        Self.runningRequests.insert(urlString)
        task.resume()
    }
}
//
//let imageCache = NSCache<NSString, UIImage>()
//extension UIImageView {
//    func loadImageUsingCache(withUrl urlString: String) {
//        let url = URL(string: urlString)
//        if url == nil {return}
//
//        // check cached image
//        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
//            self.image = cachedImage
//            return
//        }
//
//        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
//        addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//        activityIndicator.center = self.center
//
//        // if not, download image from url
//        URLSession.shared.dataTask(with: url!, completionHandler: { data, _, error in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async {
//                if let image = UIImage(data: data!) {
//                    imageCache.setObject(image, forKey: urlString as NSString)
//                    self.image = image
//                    activityIndicator.removeFromSuperview()
//                }
//            }
//        }).resume()
//    }
//}
