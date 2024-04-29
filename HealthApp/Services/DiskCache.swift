//
//  DiskCache.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import Foundation
class DiskCache {
    static let shared = DiskCache()
    
    func readImageFromDiskCache(imageKey: String) -> Data? {
        let fileURL = getCacheFileURL(imageKey: imageKey)
        return try? Data(contentsOf: fileURL)
    }
    
    func writeImageToDiskCache(data: Data, imageKey: String) {
        let fileURL = getCacheFileURL(imageKey: imageKey)
        try? data.write(to: fileURL)
    }
    
    func getCacheFileURL(imageKey: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        //print(documentsDirectory)
        return documentsDirectory.appendingPathComponent(imageKey)
    }
}
