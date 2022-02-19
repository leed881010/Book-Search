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
        placeHolderImage.map { self.image = $0 }
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                DispatchQueue.main.async {
                    if let image = data.map({ UIImage(data: $0) }) {
                        self.image = image
                    }
                }
            }.resume()
        }
    }
}
