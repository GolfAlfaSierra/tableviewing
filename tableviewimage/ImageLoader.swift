//
//  ImageLoader.swift
//  tableviewimage
//
//  Created by artyom s on 06.09.2023.
//

import UIKit.UIImage

final class ImageLoader: ImageLoaderProtocol {
    private var path: String?
    private static var runningTasks = [String: URLSessionDataTask]()

    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        let hasDataTaskWithURLString = Self.runningTasks[urlString] != nil
        if hasDataTaskWithURLString {
            return
        }

        path = urlString
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            Self.runningTasks.removeValue(forKey: urlString)

            guard let data, let image = UIImage(data: data) else {
                return
            }

            if urlString != self.path {
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }

        Self.runningTasks[urlString] = task
        task.resume()
    }
}
