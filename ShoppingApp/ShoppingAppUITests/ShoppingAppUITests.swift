//
//  ShoppingAppUITests.swift
//  ShoppingAppUITests
//
//  Created by Dipti Yadav on 11/10/23.
//

import XCTest

final class ShoppingAppUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var app: XCUIApplication!
  override func setUpWithError() throws {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launch()
  }

  override func tearDownWithError() throws {
  }

  func testCategoriesTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let categoriesTab = tabBar.buttons["Categories"]
    let allProductsButton = tabBar.buttons["All Products"]
    let cartButton = tabBar.buttons["Cart"]
    let wishlistButton = tabBar.buttons["WishList"]
    let accountButton = tabBar.buttons["Account"]

    XCTAssertTrue(categoriesTab.waitForExistence(timeout: 5))
    XCTAssertTrue(allProductsButton.waitForExistence(timeout: 5))
    XCTAssertTrue(cartButton.waitForExistence(timeout: 5))
    XCTAssertTrue(wishlistButton.waitForExistence(timeout: 5))
    XCTAssertTrue(accountButton.waitForExistence(timeout: 5))

    categoriesTab.tap()

    let collectionViewsQuery = app.collectionViews
    let category = collectionViewsQuery.buttons["Smartphones"]
    XCTAssertTrue(category.waitForExistence(timeout: 5))
    category.tap()
    let oneProduct = collectionViewsQuery.buttons["$549.00, Brand: Apple"]
    XCTAssertTrue(oneProduct.waitForExistence(timeout: 5))
    oneProduct.tap()

    let scrollViewsQuery = app.scrollViews
    let elementsQuery = scrollViewsQuery.otherElements
    elementsQuery.staticTexts["Title: iPhone 9"].tap()
    let wishlist = elementsQuery.buttons["Love"]
    XCTAssertTrue(wishlist.waitForExistence(timeout: 5))
    let addToCart = elementsQuery.buttons["Add to Cart"]
    XCTAssertTrue(addToCart.waitForExistence(timeout: 5))
  }

  func testCartTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let cartTab = tabBar.buttons["Cart"]
    XCTAssertTrue(cartTab.waitForExistence(timeout: 5))
    cartTab.tap()

    let emptyCartText = app.staticTexts["Cart is empty"]
    let emptyCartImage = app.images["emptyCartImage"]

    if emptyCartText.exists {
      XCTAssertTrue(emptyCartText.exists, "Empty cart text is present")
      XCTAssertTrue(emptyCartImage.exists, "Empty cart image is present")
    } else {
      let navigationTitle = app.navigationBars["Cart"]
      XCTAssertTrue(navigationTitle.exists)

      let collectionViewsQuery = app.collectionViews
      let checkoutButton = collectionViewsQuery.staticTexts["Checkout"]


      XCTAssertTrue(checkoutButton.exists)
      checkoutButton.tap()

      let firstNameField = app.textFields["First Name"]
      firstNameField.tap()
      firstNameField.typeText("Dipti")

      let lastNameField = app.textFields["Last Name"]
      lastNameField.tap()
      lastNameField.typeText("Yadav")

      XCTAssertEqual(firstNameField.value as? String, "Dipti")
      XCTAssertEqual(lastNameField.value as? String, "Yadav")


      let placeOrder = app.buttons["Place Order"]
      XCTAssertTrue(placeOrder.exists, "Place Order button is present")

      placeOrder.tap()

      let image = app.images["placeOrderImage"]
      XCTAssertTrue(image.exists)
    }
  }

  func testWishlistTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let wishlistTab = tabBar.buttons["WishList"]
    XCTAssertTrue(wishlistTab.waitForExistence(timeout: 5))
    wishlistTab.tap()

    let emptyWishlistImage = app.images["shoppingBags"]
    let emptyWishlistText = app.staticTexts["Product is not Selected in WishList"]

    if emptyWishlistImage.exists && emptyWishlistText.exists {
      XCTAssertTrue(emptyWishlistImage.exists, "Empty wishlist image is present")
      XCTAssertTrue(emptyWishlistText.exists, "Empty wishlist text is present")
    } else {
      let wishlistTitle = app.staticTexts["Wish List"]
      XCTAssertTrue(wishlistTitle.exists, "Wishlist title is present")
      let specificProductTitle = app.staticTexts["Title: iPhone 9"]
      XCTAssertTrue(specificProductTitle.exists, "Specific product title is in the wishlist")
    }
  }

  func testMyAccountTab() {
    let tabBar = app.tabBars["Tab Bar"]
    let accountTab = tabBar.buttons["Account"]
    XCTAssertTrue(accountTab.waitForExistence(timeout: 5))
    accountTab.tap()

    let helloText = app.staticTexts["Hello Dipti"]
    XCTAssertTrue(helloText.exists, "Greeting text is present")

    let ordersButton = app.buttons["Your Orders"]
    XCTAssertTrue(ordersButton.exists, "Order Button is Present")

    ordersButton.tap()

    let noOrdersText = app.staticTexts["No order Placed"]
    let emptyCartImage = app.images["emptyCartImage"]

    if noOrdersText.exists && emptyCartImage.exists {
      XCTAssertTrue(noOrdersText.exists, "No orders text")
      XCTAssertTrue(emptyCartImage.exists, "Empty cart image is present")
    } else {
      let ordersTitle = app.navigationBars.staticTexts["Orders"]
      XCTAssertTrue(ordersTitle.exists, "Orders navigation title")
    }
  }

  func testLaunchViewTextDisplay() {
    let launchViewImage = app.images["blackbagBackground"]
    XCTAssertTrue(launchViewImage.exists)

    let text = "VelvetVibe"
    for (index, character) in text.enumerated() {
      let characterElement = app.staticTexts[character.description]
      XCTAssertTrue(characterElement.exists, "Character \(character) at index \(index) does not exist")
    }
  }

  let textLength = "VelvetVibe".count

  func testLaunchViewAnimation() {
    let expectation = XCTestExpectation(description: "Wait for animations to complete")
    let totalAnimationTime = TimeInterval(textLength) + 1.0
    DispatchQueue.main.asyncAfter(deadline: .now() + totalAnimationTime) {
    expectation.fulfill()
    }
    wait(for: [expectation], timeout: totalAnimationTime + 1)
    let list = app.collectionViews
    XCTAssertTrue(list.element.exists)
  }
}
