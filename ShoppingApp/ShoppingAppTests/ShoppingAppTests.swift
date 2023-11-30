//
//  ShoppingAppTests.swift
//  ShoppingAppTests
//
//  Created by Dipti Yadav on 11/10/23.
//

import XCTest
@testable import ShoppingApp

final class ShoppingAppTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var viewModel: ProductsViewModel!
  // swiftlint:disable:next implicitly_unwrapped_optional
  var mockNetworkStore: MockNetworkStore!
  let cartViewModel = CartViewModel()
  let wishListViewModel = WishlistViewModel()

  override func setUpWithError() throws {
    super.setUp()
    mockNetworkStore = MockNetworkStore()
    viewModel = ProductsViewModel(networkStore: mockNetworkStore)
  }

  override func tearDownWithError() throws {}
  let product = Product(
    id: 1,
    title: "iPhone 9",
    description: "An apple mobile which is nothing like apple",
    price: 549,
    discountPercentage: 12.96,
    rating: 4.69,
    stock: 94,
    brand: "Apple",
    category: "smartphones",
    thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg"),
    images: [
      URL(string: "https://i.dummyjson.com/data/products/1/1.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/2.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/3.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/4.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")
    ]
  )

  func testFetchProductsRealNetworkCall() async {
    mockNetworkStore.mockProducts = [product]

    await viewModel.getEntries()
    if case .success(let data) = viewModel.state {
      XCTAssertEqual(data, mockNetworkStore.mockProducts)
    } else {
      XCTFail("Expected success state with products")
    }
  }
  func testFetchCategoriesRealNetworkCall() async {
    mockNetworkStore.mockCategories = ["smartphones"]
    await viewModel.getCategories()
    if case .successString(let data) = viewModel.state {
      XCTAssertEqual(data, mockNetworkStore.mockCategories)
    } else {
      XCTFail("Expected success state with products")
    }
  }

  func testAddRemoveProduct() {
    let productToAdd = product
    cartViewModel.productsInCart.append(productToAdd)
    XCTAssertTrue(cartViewModel.productsInCart.contains(productToAdd), "Product should be added to cart")

    cartViewModel.productsInCart.removeAll { $0 == productToAdd }

    XCTAssertFalse(cartViewModel.productsInCart.contains(productToAdd), "Product should be removed from cart")
    XCTAssertEqual(cartViewModel.productsInCart.count, 0)

    let totalPrice = cartViewModel.productsInCart.reduce(0) { $0 + $1.price }
    XCTAssertEqual(totalPrice, 0)
  }

  func testPersistence() {
    let productToAdd = product
    cartViewModel.productsInCart.append(productToAdd)
    cartViewModel.saveItemsInCartToDocumentDirectory()

    let newViewModel = CartViewModel()

    XCTAssertTrue(newViewModel.productsInCart.contains(productToAdd), "Product is persisted and loaded")
  }

  func testAddRemoveWishlistProduct() {
    let productToAdd = product
    wishListViewModel.productsInWishlist.append(productToAdd)

    XCTAssertTrue(wishListViewModel.productsInWishlist.contains(productToAdd), "Product should be added to wishlist")

    wishListViewModel.productsInWishlist.removeAll { $0 == productToAdd }
    XCTAssertFalse(
      wishListViewModel.productsInWishlist.contains(productToAdd),
      "Product should be removed from wishlist"
    )
  }
}
