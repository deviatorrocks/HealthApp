//
//  ImageCache.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: key as AnyObject) as? UIImage
    }
}
