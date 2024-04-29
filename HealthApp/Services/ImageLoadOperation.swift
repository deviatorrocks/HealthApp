//
//  ImageLoadOperation.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
import UIKit

class ImageLoadOperation: Operation {
    private let url: URL
    var image: UIImage?
    
    init(url: URL) {
        self.url = url
    }
    
    override func main() {
        if isCancelled { return }
        
        guard let data = try? Data(contentsOf: url) else { return }
        if isCancelled {
            return
        }
        image = UIImage(data: data)
    }
}
