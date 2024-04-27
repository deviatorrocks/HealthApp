//
//  ImageKey.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation

struct DetailItem: Codable {
    let title: String
    let thumbnail: ImageData
}

struct ImageData: Codable {
    let domain: String
    let basePath: String
    let key: String
}
