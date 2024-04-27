//
//  ImageService.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation

class ImageService: ImageServiceProtocol {
    
    func fetchImageInfo(completion: @escaping ([DetailItem]?, NetworkError?) -> Void) {
        guard let url = URL(string: Constants.url) else {
            completion(nil, .invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, .invalidStatusCode)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let imageKeys = try decoder.decode([DetailItem].self, from: data)
                completion(imageKeys, nil)
            } catch {
                completion(nil, .jsonserialisationFailed)
            }
        }.resume()
    }
}
