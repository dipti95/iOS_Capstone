//
//  Product.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import Foundation

// according to https://dummyjson.com/products
struct ProductApi: Codable {
  let products: [Product]
  let total: Int
  let skip: Int
  let limit: Int
}

struct Product: Codable, Hashable, Identifiable {
  let id: Int
  let title: String
  let description: String
  let price: Double
  let discountPercentage: Double
  let rating: Double
  let stock: Int
  let brand: String
  let category: String
  let thumbnail: URL?
  let images: [URL?]

//  enum CodingKeys: String, CodingKey {
//    case id
//    case title
//    case description
//    case price
//    case discountPercentage
//    case rating
//    case stock
//    case brand
//    case category
//    case thumbnail
//    case images
//  }
}
