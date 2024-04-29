//
//  ImageListViewModelTests.swift
//  HealthAppTests
//
//  Created by Mandar Kadam on 29/04/24.
//

import XCTest
@testable import HealthApp

final class ImageListViewModelTests: XCTestCase {
    
    class MockImageService: ImageServiceProtocol {
        var imageInfoToReturn: [DetailItem]?
        var errorToReturn: NetworkError?
        
        func fetchImageInfo(completion: @escaping ([DetailItem]?, NetworkError?) -> Void) {
            completion(imageInfoToReturn, errorToReturn)
        }
    }
    
    var viewModel: ImageListViewModel!
    var mockImageService: MockImageService!
    
    override func setUp() {
        super.setUp()
        mockImageService = MockImageService()
        viewModel = ImageListViewModel(imageService: mockImageService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockImageService = nil
        super.tearDown()
    }
    
    func testFetchImageKeys_Success() {
        let expectedImageKeys = [DetailItem(title: "ABCD", thumbnail: ImageData(domain: "example.com", basePath: "images", key: "image1"))]
        mockImageService.imageInfoToReturn = expectedImageKeys
        
        let expectation = XCTestExpectation(description: "Fetch image keys")
        viewModel.fetchImageKeys { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.imageKeys.count, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchImageKeys_Failure() {
        mockImageService.errorToReturn = .invalidURL
        
        let expectation = XCTestExpectation(description: "Fetch image keys")
        viewModel.fetchImageKeys { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.fetchStatusCode(), NetworkError.invalidURL.fetchStatusCode())
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchImageKey() {
        let index = 0
        let expectedImageKey = "image1-0"
        viewModel.imageKeys = [DetailItem(title: "ABCD",
                                          thumbnail: ImageData(domain: "example.com",
                                                               basePath: "images",
                                                               key: "image1"))]
        let imageKey = viewModel.fetchImageKey(index: index)
        XCTAssertEqual(imageKey, expectedImageKey)
    }
    
    func testFormImageUrl() {
        let index = 0
        let expectedImageUrl = "example.com/images/0/image1"
        viewModel.imageKeys = [DetailItem(title: "ABCD",
                                          thumbnail: ImageData(domain: "example.com",
                                                               basePath: "images",
                                                               key: "image1"))]
        let imageUrl = viewModel.formImageUrl(index: index)
        XCTAssertEqual(imageUrl as String, expectedImageUrl)
    }
}
