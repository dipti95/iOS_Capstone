//
//  OrderViewModel.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/14/23.
//

import Foundation


class OrderViewModel: ObservableObject {
  @Published var order: [Order] = [] {
    didSet {
      saveItemsInOrdersToDocumentDirectory()
    }
  }

  init() {
    loadItemsInOrdersFromDocumentDirectory()
  }


  func saveItemsInOrdersToDocumentDirectory() {
    print(Bundle.main.bundleURL)
    print(FileManager.documentsDirectoryURL)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let wishlistData = try encoder.encode(order)

      let jsonWishlistDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("orders")
        .appendingPathExtension("json")
      try wishlistData.write(to: jsonWishlistDataURL)
    } catch {
      print("Error encoding cart data to JSON file")
    }
  }


  func loadItemsInOrdersFromDocumentDirectory() {
    let jsonWishlistDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("orders")
      .appendingPathExtension("json")
    do {
      let jsonWishlistDataFromURL = try Data(contentsOf: jsonWishlistDataURL)

      let decoder = JSONDecoder()
      let decodedData = try decoder.decode([Order].self, from: jsonWishlistDataFromURL)
      order = decodedData
      return
    } catch {
      print("Failure to load JSON file from Documents Directory")
    }
  }
}
