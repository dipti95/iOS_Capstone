//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import Foundation

@MainActor
class ProductsViewModel: ObservableObject {
  @Published var state: State = .initial

  let networkStore = NetworkStore()

  func getEntries() async {
    do {
      let product = try await getData()
      state = .success(data: product)
    } catch {
      state = .failed(error: error)
      print(error.localizedDescription)
    }
  }

  private func getData() async throws -> [Product] {
    if let data = try? await networkStore.fetchEntries() {
      print("Data loaded from network.")
      return data
    }
    throw AppError.general
  }
}


extension ProductsViewModel {
  enum State {
    case initial

    case success(data: [Product])

    case failed(error: Error)
  }
}

enum AppError: LocalizedError {
  case general

  var errorDescription: String? {
    switch self {
    case .general:
      return "Uh-oh, something's gone wrong. Please check again later"
    }
  }
}
