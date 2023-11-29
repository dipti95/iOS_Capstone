//
//  ShoppingAppUITests.swift
//  ShoppingAppUITests
//
//  Created by Dipti Yadav on 11/10/23.
//

import XCTest

final class ShoppingAppUITests: XCTestCase {
  let app = XCUIApplication()
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    app.launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    continueAfterFailure = false
    app.launch()
  }

  func testExample() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()

    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func test_allTabButtonsInTabbar() throws {
    let categoriesTab = app.buttons["Categories"]
    let allProductsTab = app.buttons["All Products"]
    let exists = NSPredicate(format: "exists == true")
    expectation(for: exists, evaluatedWith: categoriesTab, handler: nil)
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertTrue(categoriesTab.exists)
    XCTAssertTrue(allProductsTab.exists)
  }

  func testCategoriesTab() {
    let categoriesTab = app.buttons["Categories"]
    XCTAssertTrue(categoriesTab.waitForExistence(timeout: 5))
    categoriesTab.tap()

    let navigationTitle = app.navigationBars["Categories"]
      XCTAssertTrue(navigationTitle.exists)

      let exampleCategory = app.buttons["Smartphones"]
      XCTAssertTrue(exampleCategory.waitForExistence(timeout: 5))
  }

  func testAllProductsTab() {
    let allProductsTab = app.buttons["All Products"]
    XCTAssertTrue(allProductsTab.waitForExistence(timeout: 5))
    allProductsTab.tap()
  }

  func testCartTab() {
    let cartTab = app.buttons["Cart"]
    XCTAssertTrue(cartTab.waitForExistence(timeout: 5))
    cartTab.tap()
    // Add more assertions here
  }

  func testWishlistTab() {
    let wishlistTab = app.buttons["WishList"]
    XCTAssertTrue(wishlistTab.waitForExistence(timeout: 5))
    wishlistTab.tap()
    // Add more assertions here
    let emptyWishlistImage = app.images["shoppingBags"]
    let emptyWishlistText = app.staticTexts["Product is not Selected in WishList"]

    print(emptyWishlistText.exists)

    if emptyWishlistImage.exists && emptyWishlistText.exists {
      XCTAssertTrue(emptyWishlistImage.exists, "Empty wishlist image should be present")
      XCTAssertTrue(emptyWishlistText.exists, "Empty wishlist text should be present")
    } else {
      let wishlistTitle = app.staticTexts["Wish List"]
      XCTAssertTrue(wishlistTitle.exists, "Wishlist title should be present")
      let specificProductTitle = app.staticTexts["Title: iPhone 9"]
      XCTAssertTrue(specificProductTitle.exists, "Specific product title should exist in the wishlist")
    }
  }

  func testMyAccountTab() {
    let accountTab = app.buttons["Account"]
    XCTAssertTrue(accountTab.waitForExistence(timeout: 5))
    accountTab.tap()
    // Add more assertions here
  }


  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
