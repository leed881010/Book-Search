//
//  ImageCacheManager.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

protocol ImageCacheManagerProtocol {
    
    func get(for key: URL) -> UIImage?
    func set(image: UIImage, for key: URL)
}

final class ImageCacheManager {
    
    static let shared: ImageCacheManagerProtocol = ImageCacheManager()
    
    let memoryCach = NSCache<NSString, UIImage>()
    let fileManager: FileManager = FileManager.default
    
}

private extension ImageCacheManager {
    
    func setMemory(image: UIImage, for key: URL) {
        self.memoryCach.setObject(image, forKey: key.lastPathComponent as NSString)
    }
    
    func setDisk(image: UIImage, for key: URL) {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true).first else { return }
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(key.lastPathComponent)
        guard !self.fileManager.fileExists(atPath: filePath.path) else { return }
        
        self.fileManager.createFile(atPath: filePath.path, contents: image.jpegData(compressionQuality: 0.4), attributes: nil)
    }
}

extension ImageCacheManager: ImageCacheManagerProtocol {
    
    func get(for key: URL) -> UIImage? {
        if let image = self.get(memory: key) {
            return image
        }
        
        if let image = self.get(disk: key) {
            return image
        }
        
        return nil
    }
    
    func set(image: UIImage, for key: URL) {
        self.setMemory(image: image, for: key)
        self.setDisk(image: image, for: key)
    }
}

extension ImageCacheManager {
    
    func get(memory key: URL) -> UIImage? {
        return self.memoryCach.object(forKey: key.lastPathComponent as NSString)
    }
    
    func get(disk key: URL) -> UIImage? {
        guard let path = self.fileManager.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return nil }
        let filePath = path.appendingPathComponent(key.lastPathComponent)
        
        guard self.fileManager.fileExists(atPath: filePath.path) else { return nil }
        if let data = try? Data(contentsOf: filePath),
            let image = UIImage(data: data) {
            self.setMemory(image: image, for: key)
            return image
            
        } else {
            return nil
        }
    }
    
}
