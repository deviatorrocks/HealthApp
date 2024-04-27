//
//  ImageServiceProtocol.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
protocol ImageServiceProtocol {
    func fetchImageInfo(completion: @escaping ([DetailItem]?, NetworkError?) -> Void)
}
