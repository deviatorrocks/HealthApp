//
//  ImageCacheTests.swift
//  HealthAppTests
//
//  Created by Mandar Kadam on 29/04/24.
//

import XCTest

final class ImageCacheTests: XCTestCase {
    
    func testSetImage() {
        let cache = ImageCache.shared
        let key = "testImage"
        let image = UIImage(named: "test_image")!
        cache.setImage(image, for: key)
        XCTAssertEqual(cache.image(for: key), image)
    }
    
    func testImageForKey() {
        let cache = ImageCache.shared
        let key = "testImage"
        let image = UIImage(named: "test_image")!
        cache.setImage(image, for: key)
        XCTAssertEqual(cache.image(for: key), image)
    }
    
    func testImageForNoKey() {
        let cache = ImageCache.shared
        let key = "nonExistingKey"
        XCTAssertNil(cache.image(for: key))
    }
}

