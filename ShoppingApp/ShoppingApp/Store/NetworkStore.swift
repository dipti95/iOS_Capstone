//
//  NetworkStore.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import Foundation

struct NetworkStore {
  var endpoint = URL(string: "https://dummyjson.com/products")

  func fetchEntries() async throws -> [Product] {
    guard let url = endpoint else {
      print("endpoint")
      throw AppError.general
    }

    let urlSession = URLSession.shared
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
}
