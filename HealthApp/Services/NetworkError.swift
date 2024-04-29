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
    
    func fetchStatusCode() -> Int {
        switch self {
        case .failedToDecode: return 111
        case .invalidStatusCode: return 112
        case .invalidURL: return 113
        case .emptyData: return 114
        case .jsonserialisationFailed: return 115
        case .customError(error: _):
            return 116
        }
    }
}
