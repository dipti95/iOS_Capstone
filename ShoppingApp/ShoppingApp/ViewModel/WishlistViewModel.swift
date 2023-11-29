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
      saveItemsInWishlistToDocumentDirectory()
    }
  }

  init() {
    loadItemsInWishlistFromDocumentDirectory()
  }


  func saveItemsInWishlistToDocumentDirectory() {
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
      print("Error encoding data")
    }
  }


  func loadItemsInWishlistFromDocumentDirectory() {
    let jsonWishlistDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("wishlist")
      .appendingPathExtension("json")
    do {
      let jsonWishlistDataFromURL = try Data(contentsOf: jsonWishlistDataURL)

      let decoder = JSONDecoder()
      let decodedData = try decoder.decode([Product].self, from: jsonWishlistDataFromURL)
      productsInWishlist = decodedData
      return
    } catch {
      print("Failure to load JSON file(wishlist) from Documents Directory")
    }
  }
}
