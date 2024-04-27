//
//  ImageLoader.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
import UIKit

class ImageLoader {
    private let queue = OperationQueue()
    private var operations: [URL: ImageLoadOperation] = [:]
    
    func loadImage(imageKey: String, from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if image is in memory cache
        if let image = ImageCache.shared.image(for: imageKey) {
            completion(image)
            return
        }
        
        // Check if image is in disk cache
        if let cachedData = DiskCache.shared.readImageFromDiskCache(imageKey: imageKey),
           let image = UIImage(data: cachedData) {
            // Cache image in memory
            ImageCache.shared.setImage(image, for: imageKey)
            completion(image)
            return
        }

        
        if let existingOperation = operations[url] {
            existingOperation.completionBlock = {
                DispatchQueue.main.async {
                    completion(existingOperation.image)
                }
            }
            return
        }
        
        let operation = ImageLoadOperation(url: url)
        operation.completionBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let image = operation.image,
                   let data = image.convertImageToData() {
                    // Cache image on disk
                    DiskCache.shared.writeImageToDiskCache(data: data, imageKey: imageKey)
                    
                    // Cache image in memory
                    ImageCache.shared.setImage(image, for: imageKey)
                }
                
                completion(operation.image)
            }
            self.operations.removeValue(forKey: url)
        }
        
        operations[url] = operation
        queue.addOperation(operation)
    }
}
