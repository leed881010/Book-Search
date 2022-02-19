//
//  UIImageView+.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

extension UIImageView {
    
    func update(imageURL: URL?, placeHolderImage: UIImage? = nil) {
        guard let imageURL = imageURL else {
            self.image = nil
            return
        }
        let cacheManager: ImageCacheManagerProtocol = ImageCacheManager.shared
        if let cachedImage = cacheManager.get(for: imageURL) {
            self.image = cachedImage
        }
        
        placeHolderImage.map { self.image = $0 }
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                DispatchQueue.main.async {
                    if let image = data.flatMap ({ UIImage(data: $0) }) {
                        cacheManager.set(image: image, for: imageURL)
                        self.image = image
                    }
                }
            }.resume()
        }
    }
}
