//
//  ViewController.swift
//  tableviewimage
//
//  Created by artyom s on 06.09.2023.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void)
}

let imagesURLSTUB = [
    "https://images.unsplash.com/photo-1693333415015-cd77db7e82fd?ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQzNTM5ODJ8&ixlib=rb-4.0.3&q=85&w=720",
    "https://images.unsplash.com/photo-1692606526099-551f34037811?ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQzNTQwMDJ8&ixlib=rb-4.0.3&q=85&w=720",
    "https://images.unsplash.com/photo-1692606743169-e1ae2f0a960f?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQxODcyNDF8&ixlib=rb-4.0.3&q=85",
    "https://images.unsplash.com/photo-1692799777373-42655f895bcf?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQxODcyMTV8&ixlib=rb-4.0.3&q=85",
    "https://images.unsplash.com/photo-1692455151728-85b49a956d45?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyNTB8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1691651642631-5ae894859b06?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyNDl8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1691580438246-a6e5cb35ca05?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyNDd8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1692394950102-34e14fafa12d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyNDV8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1632012643837-1163a4297c24?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyNDN8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1692736230219-d2c2d9afeecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyMzh8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1693550672814-0e2c8f37e27e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyMzZ8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1692712798353-a7754b750186?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyMzR8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1693201664010-8a8fd02f6711?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyMzJ8&ixlib=rb-4.0.3&w=720",
    "https://images.unsplash.com/photo-1692909026913-a5b0b0b1b5fe?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTA3NjF8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQwMTgyMDN8&ixlib=rb-4.0.3&w=720"
]

final class ViewController: UIViewController {
    let dataSource = DataSource()
    let dataSourcePrefetching = DataSourcePrefetching()

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.CELL_ID)
            tableView.dataSource = dataSource
            tableView.prefetchDataSource = dataSourcePrefetching
            tableView.allowsSelection = false
            tableView.rowHeight = 300
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

final class DataSource: NSObject, UITableViewDataSource {
    let imageLoader: ImageLoaderProtocol = ImageLoader()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imagesURLSTUB.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.CELL_ID) as! ImageTableViewCell
        let urlString = imagesURLSTUB[indexPath.row]

        imageLoader.loadImage(urlString: urlString) { image in
            cell.updateState(image: image)
        }

        return cell
    }
}

final class DataSourcePrefetching: NSObject, UITableViewDataSourcePrefetching {
    let imageLoader: ImageLoaderProtocol = ImageLoader()

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            imageLoader.loadImage(urlString: imagesURLSTUB[indexPath.row], completion: { _ in })
        }
    }
}
