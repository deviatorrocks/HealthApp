//
//  NetworkError.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case customError(error: Error)
    case failedToDecode
    case invalidStatusCode
    case invalidURL
    case emptyData
    case jsonserialisationFailed
}
