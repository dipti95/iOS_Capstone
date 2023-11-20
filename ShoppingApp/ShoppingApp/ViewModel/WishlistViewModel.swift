//
//  WishlistViewModel.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/14/23.
//

import Foundation


class WishlistViewModel: ObservableObject {
  @Published var productsInWishlist: [Product] = [] {
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
      let wishlistData = try encoder.encode(productsInWishlist)

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
      let decodedData = try decoder.decode([Product].self, from: jsonWishlistDataFromURL)
      productsInWishlist = decodedData
      return
    } catch {
      print("Initial run of app or failure loading JSON file from Documents Directory")
    }
  }
}
