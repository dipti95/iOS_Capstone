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
      saveItemsInCartToDocumentDirectory()
    }
  }

  init() {
    loadItemsInCartFromDocumentDirectory()
  }


  func saveItemsInCartToDocumentDirectory() {
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
      print("Error encoding data")
    }
  }


  func loadItemsInCartFromDocumentDirectory() {
    let jsonCartDataURL = FileManager.documentsDirectoryURL.appendingPathComponent("ProductInCart")
      .appendingPathExtension("json")
    do {
      let jsonCartDataFromURL = try Data(contentsOf: jsonCartDataURL)

      let decoder = JSONDecoder()
      let decodedData = try decoder.decode([Product].self, from: jsonCartDataFromURL)
      productsInCart = decodedData
      return
    } catch {
      print("Failure to load JSON file from Documents Directory")
    }
  }
}
