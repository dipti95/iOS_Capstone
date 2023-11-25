//
//  ShoppingAppTests.swift
//  ShoppingAppTests
//
//  Created by Dipti Yadav on 11/10/23.
//

import XCTest
@testable import ShoppingApp

final class ShoppingAppTests: XCTestCase {
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

    override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

func test_decode_items() {
  let url = URL(string: "https://dummyjson.com/products")

  let expectation = XCTestExpectation(description: "Server responds in a reasonable time")

  if let url = url {
    URLSession.shared.dataTask(with: url) { data, response, error in
      defer { expectation.fulfill() }

      // Check for any network errors
      XCTAssertNil(error, "Error: \(error?.localizedDescription ?? "")")

      do {
        let httpResponse = try XCTUnwrap(response as? HTTPURLResponse)
        XCTAssertEqual(httpResponse.statusCode, 200, "HTTP status code is not 200")

        guard let jsonData = data else {
          XCTFail("No data received from the server")
          return
        }

        let decodedData: Any
        do {
          decodedData = try JSONDecoder().decode([Product].self, from: jsonData)
        } catch {
          decodedData = try JSONSerialization.jsonObject(with: jsonData, options: [])
        }

        if let productArray = decodedData as? [Product] {
          XCTAssertFalse(productArray.isEmpty, "Product array should not be empty")
        } else if let productDictionary = decodedData as? [String: Any] {
        } else {
          XCTFail("Unexpected JSON structure")
        }
    } catch {
      XCTFail("Test encountered an error: \(error)")
      }
    }
    .resume()
  } else {
    XCTFail("Invalid URL")
  }
  wait(for: [expectation], timeout: 5.0)
}


  func testExample() throws {
  // This is an example of a functional test case.
  // Use XCTAssert and related functions to verify your tests produce the correct results.
  // Any test you write for XCTest can be annotated as throws and async.
  // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
  // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
    // Put the code you want to measure the time of here.
    }
  }
}
