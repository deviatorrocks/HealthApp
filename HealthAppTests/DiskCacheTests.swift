//
//  DiskCacheTests.swift
//  HealthAppTests
//
//  Created by Mandar Kadam on 29/04/24.
//

import XCTest

final class DiskCacheTests: XCTestCase {
    
    func testWriteImageToDiskCache() {
        let cache = DiskCache.shared
        let imageKey = "testImage"
        let testData = "Test data".data(using: .utf8)!
        cache.writeImageToDiskCache(data: testData, imageKey: imageKey)
        
        let fileURL = cache.getCacheFileURL(imageKey: imageKey)
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
    }
    
    func testReadImageFromDiskCache() {
        let cache = DiskCache.shared
        let imageKey = "testImage"
        let testData = "Test data".data(using: .utf8)!
        cache.writeImageToDiskCache(data: testData, imageKey: imageKey)
        
        let readData = cache.readImageFromDiskCache(imageKey: imageKey)
        XCTAssertEqual(readData, testData)
    }
    
    func testGetCacheFileURL() {
        let cache = DiskCache.shared
        let imageKey = "testImage"
        let fileURL = cache.getCacheFileURL(imageKey: imageKey)
        XCTAssertEqual(fileURL.lastPathComponent, imageKey)
    }
}

