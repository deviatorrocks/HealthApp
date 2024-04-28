//
//  UIImage+Extension.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
import UIKit

extension UIImage {
    func centerCropped(to targetSize: CGSize) -> UIImage? {
        guard let cgImage = cgImage else { return nil }

        let imageSize = CGSize(width: CGFloat(cgImage.width), height: CGFloat(cgImage.height))
        let scale: CGFloat = max(targetSize.width / imageSize.width, targetSize.height / imageSize.height)

        let width = imageSize.width * scale
        let height = imageSize.height * scale

        let x = (targetSize.width - width) / 2.0
        let y = (targetSize.height - height) / 2.0

        let rect = CGRect(x: x, y: y, width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.interpolationQuality = .high
        draw(in: rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func convertImageToData(asJPEG: Bool = false, compressionQuality: CGFloat = 0.8) -> Data? {
        if let data = asJPEG ? self.jpegData(compressionQuality: compressionQuality) : self.pngData() {
            return data
        } else {
            return nil
        }
    }
}

