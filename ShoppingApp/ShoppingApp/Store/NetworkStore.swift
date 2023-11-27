//
//  NetworkStore.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import Foundation

struct NetworkStore {
  var productsAPI = URL(string: "https://dummyjson.com/products")
  let urlSession = URLSession.shared

  func fetchEntries() async throws -> [Product] {
    guard let url = productsAPI else {
      print("endpoint")
      throw AppError.general
    }


    let (data, response) = try await urlSession.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      print("status")
      throw AppError.general
    }

    guard let decodedData = try? JSONDecoder().decode(ProductApi.self, from: data) else {
      print("decode")
      throw AppError.general
    }
    if decodedData.products.isEmpty {
      print("endpoint")
      throw AppError.general
    }

    return decodedData.products
  }


  func fetchCategories() async throws -> [String] {
    guard let url = URL(string: "https://dummyjson.com/products/categories") else {
      print("ProductCategoriesAPI")
      throw AppError.general
    }
    let (data, response) = try await urlSession.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      print("status")
      throw AppError.general
    }

    guard let decodedData = try? JSONDecoder().decode([String].self, from: data) else {
      print("decode")
      throw AppError.general
    }
    return decodedData
  }
}
