//
//  NetworkStore.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import Foundation

protocol NetworkStoring {
  func fetchEntries() async throws -> [Product]
  func fetchCategories() async throws -> [String]
}

struct NetworkStore: NetworkStoring {
  var productsAPI = URL(string: "https://dummyjson.com/products")
  let urlSession = URLSession.shared

  func fetchEntries() async throws -> [Product] {
    guard let url = productsAPI else {
      throw AppError.urlError
    }

    let (data, response) = try await urlSession.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw AppError.statusCodeError
    }

    guard let decodedData = try? JSONDecoder().decode(ProductApi.self, from: data) else {
      throw AppError.decodingError
    }

    if decodedData.products.isEmpty {
      throw AppError.emptyDataError
    }

    return decodedData.products
  }

  func fetchCategories() async throws -> [String] {
    guard let url = URL(string: "https://dummyjson.com/products/categories") else {
      print("ProductCategoriesAPI")
      throw AppError.urlError
    }
    let (data, response) = try await urlSession.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      print("status category")
      throw AppError.statusCodeError
    }

    guard let decodedData = try? JSONDecoder().decode([String].self, from: data) else {
      print("decode")
      throw AppError.decodingError
    }
    return decodedData
  }
}


class MockNetworkStore: NetworkStoring {
  var mockProducts: [Product]?
  var mockCategories: [String]?
  var error: Error?

  func fetchEntries() async throws -> [Product] {
    if let error = error {
      throw error
    }
    return mockProducts ?? []
  }

  func fetchCategories() async throws -> [String] {
    if let error = error {
      throw error
    }
    return mockCategories ?? []
  }
}
