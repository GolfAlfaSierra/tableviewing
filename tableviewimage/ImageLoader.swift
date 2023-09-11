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
    private var imagePath = ""

    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        imagePath = urlString
        guard let url = URL(string: urlString) else {
            print("cannot convert \(urlString) to URL")
            return
        }

        if let cachedImage = Self.imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                if self.imagePath != urlString {return}
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
                if self.imagePath != urlString {return}
                completion(image)
            }
        }

        Self.runningRequests.insert(urlString)
        task.resume()
    }
}
