//
//  File.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/13/23.
//

import Foundation


struct Order: Identifiable, Codable {
  var id = UUID()
  let orderItems: [Product]
  let totalPrice: Double
}
