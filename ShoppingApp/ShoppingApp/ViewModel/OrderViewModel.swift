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
      saveItemsInShoppingCartToDocumentDirectory()
    }
  }

  init() {
    loadItemsInShoppingCartFromDocumentDirectory()
  }


  func saveItemsInShoppingCartToDocumentDirectory() {
    print(Bundle.main.bundleURL)
    print(FileManager.documentsDirectoryURL)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let wishlistData = try encoder.encode(order)

      let jsonWishlistDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("wishlist")
        .appendingPathExtension("json")
      try wishlistData.write(to: jsonWishlistDataURL)
    } catch {
      print("Error encoding cart data to JSON file")
    }
  }


  func loadItemsInShoppingCartFromDocumentDirectory() {
    let jsonWishlistDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("wishlist")
      .appendingPathExtension("json")
    do {
      let jsonWishlistDataFromURL = try Data(contentsOf: jsonWishlistDataURL)

      let decoder = JSONDecoder()
      let decodedData = try decoder.decode([Order].self, from: jsonWishlistDataFromURL)
      order = decodedData
      return
    } catch {
      print("Initial run of app or failure loading JSON file from Documents Directory")
    }
  }
}
