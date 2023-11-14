//
//  CartViewModel.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/13/23.
//

import Foundation


class CartViewModel: ObservableObject {
  @Published var productsInCart: [Product] = [] {
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
      let cartData = try encoder.encode(productsInCart)

      let jsonCartDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("ProductInCart")
        .appendingPathExtension("json")
      try cartData.write(to: jsonCartDataURL)
    } catch {
      print("Error encoding cart data to JSON file")
    }
  }


  func loadItemsInShoppingCartFromDocumentDirectory() {
    let jsonCartDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("ProductInCart")
      .appendingPathExtension("json")
    do {
      let jsonCartDataFromURL = try Data(contentsOf: jsonCartDataURL)

      let decoder = JSONDecoder()
      let decodedData = try decoder.decode([Product].self, from: jsonCartDataFromURL)
      productsInCart = decodedData
      return
    } catch {
      print("Initial run of app or failure loading JSON file from Documents Directory")
    }
  }
}
