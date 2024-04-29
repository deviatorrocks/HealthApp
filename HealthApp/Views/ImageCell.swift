//
//  ImageCell.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configureUI(imageLoader: ImageLoader, imageKey: String, url: String) {
        configurePlaceholderImage()
        
        // Check if the image is already cached
        if let image = ImageCache.shared.image(for: imageKey),
            let croppedImage = image.centerCropped(to: frame.size) {
            // Image is already cached
            DispatchQueue.main.async {
                self.imageView.image = croppedImage
            }
            return
        }
        
        imageLoader.loadImage(imageKey: imageKey, from: URL(string: url)!) { image in
            DispatchQueue.main.async {
                if let croppedImage = image?.centerCropped(to: self.frame.size) {
                    self.imageView.image = croppedImage
                }
            }
        }
    }
    
    func configurePlaceholderImage() {
        DispatchQueue.main.async {
            self.imageView.image = self.fetchPlaceholderImage()
        }
    }
    
    func fetchPlaceholderImage() -> UIImage {
        let image = UIImage(imageLiteralResourceName: "placeholder")
        return (image.centerCropped(to: self.frame.size))!
    }
}
