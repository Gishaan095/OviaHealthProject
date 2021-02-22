//
//  NetworkManagerTests.swift
//  OviaHealthProjectTests
//
//  Created by Ishaan Gupta 2 on 2/20/21.
//

@testable import OviaHealthProject
import XCTest

class NetworkManagerTests: XCTestCase, NetworkManagerDelegate {
  
  var networkManager: NetworkManager!
  var responseExpectation: XCTestExpectation!
  var errorThrown: Error?
  
  override func setUp() {
    super.setUp()
    networkManager = NetworkManager()
    networkManager.delegate = self
  }
  
  override  func tearDown() {
    super.tearDown()
    networkManager = nil
    responseExpectation = nil
    errorThrown = nil
  }
  
  func test_fetchData_with_no_title() throws {
    networkManager.fetchData(title: "")
    XCTAssertEqual(errorThrown as! NetworkError, NetworkError.stringToUrlFailed)
  }
  
  func test_fetchData_with_one_word_title() throws {
    responseExpectation = expectation(description: "TitleWithOneWord")
    networkManager.fetchData(title: "harry")
    wait(for: [responseExpectation], timeout: 5)
  }
  
  func test_fetchData_with_multiple_word_title() throws {
    responseExpectation = expectation(description: "TitleWithMultipleWord")
    networkManager.fetchData(title: "harry and furious")
    wait(for: [responseExpectation], timeout: 5)
  }
  
  func test_downloadImage_with_no_Url() throws {
    networkManager.downloadImage(imageUrl: "") { (error, img) in
      XCTAssertEqual(error as! NetworkError, NetworkError.invalidImageUrl)
    }
  }
  
  func test_downloadImage_with_image_url() throws {
    let imgUrl = "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
    networkManager.downloadImage(imageUrl: imgUrl) { (error, img) in
      XCTAssertNotNil(img)
    }
  }
  
  func test_downloadImage_with_wrong_image_url() throws {
    let imgUrl = "https://m.media-amazon.com/images/M/BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
    networkManager.downloadImage(imageUrl: imgUrl) { (error, img) in
      XCTAssertNil(img)
    }
  }
  
  func test_downloadImage_with_no_image_url() throws {
    let imgUrl = ""
    networkManager.downloadImage(imageUrl: imgUrl) { (error, img) in
      XCTAssertNil(img)
    }
  }
  
  func didGetResponse(networkManager: NetworkManager, response: OMDBResponse) {
    responseExpectation.fulfill()
  }
  
  func didFinishWithError(error: Error) {
    errorThrown = error
  }
}
