//
//  ImageListViewModel.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
//"https://your-api-url.com/images/0/\(imageKey)"

final class ImageListViewModel {
    private let imageService: ImageServiceProtocol
    var imageKeys: [DetailItem] = []
    
    init(imageService: ImageServiceProtocol) {
        self.imageService = imageService
    }
    
    func fetchImageKeys(completion: @escaping (NetworkError?) -> Void) {
        imageService.fetchImageInfo { [weak self] imageKeys, error in
            guard let self = self else { return }
            
            if let imageKeys = imageKeys {
                self.imageKeys = imageKeys
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func fetchImageKey(index: Int) -> String {
        let imageKey = imageKeys[index].thumbnail
        return "\(imageKey.key)-\(index)"
    }
    
    func formImageUrl(index: Int) -> NSString {
        let imageKey = imageKeys[index].thumbnail
        let imageUrl = imageKey.domain + "/" + imageKey.basePath + "/0/" + imageKey.key
        return imageUrl as NSString
    }
}
