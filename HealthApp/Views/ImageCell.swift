//
//  ImageCell.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureUI(imageLoader: ImageLoader, imageKey: String, url: String) {
        imageView.image = nil
        // Check if the image is already cached
        if let image = ImageCache.shared.image(for: imageKey),
            let croppedImage = image.centerCropped(to: imageView.frame.size) {
            // Image is already cached, no need to prefetch
                self.imageView.image = croppedImage
            return
        }
        
        imageLoader.loadImage(imageKey: imageKey, from: URL(string: url)!) { image in
            DispatchQueue.main.async {
                // Reload the corresponding cell to display the image
                if let croppedImage = image?.centerCropped(to: self.imageView.frame.size) {
                    self.imageView.image = croppedImage
                }
            }
        }
    }
}
