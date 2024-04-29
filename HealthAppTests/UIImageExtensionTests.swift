//
//  UIImageExtensionTests.swift
//  HealthAppTests
//
//  Created by Mandar Kadam on 29/04/24.
//

import XCTest

final class UIImageExtensionsTests: XCTestCase {
    
    func testCenterCropped() {
        let image = UIImage(named: "test_image")!
        let targetSize = CGSize(width: 100, height: 100)
        let croppedImage = image.centerCropped(to: targetSize)
        XCTAssertNotNil(croppedImage)
        XCTAssertEqual(croppedImage?.size, targetSize)
    }
    
    func testConvertImageToPNGData() {
        let image = UIImage(named: "test_image")!
        let imageData = image.convertImageToData()
        XCTAssertNotNil(imageData)
    }
    
    func testConvertImageToJPEGData() {
        let image = UIImage(named: "test_image")!
        let compressionQuality: CGFloat = 0.5
        let imageData = image.convertImageToData(asJPEG: true, compressionQuality: compressionQuality)
        XCTAssertNotNil(imageData)
    }
}

