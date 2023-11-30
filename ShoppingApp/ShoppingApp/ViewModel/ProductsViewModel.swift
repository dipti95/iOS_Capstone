//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import Foundation

class ProductsViewModel: ObservableObject {
  @Published var state: State = .initial

  private var networkStore: NetworkStoring

  init(networkStore: NetworkStoring) {
    self.networkStore = networkStore
  }

  @MainActor
  func getEntries() async {
    do {
      let product = try await getData()
      state = .success(data: product)
    } catch {
      state = .failed(error: error)
      print(error.localizedDescription)
    }
  }

  @MainActor
  func getCategories() async {
    do {
      let categories = try await getCategoriesData()
      state = .successString(data: categories)
    } catch {
      state = .failed(error: error)
      print(error.localizedDescription)
    }
  }

  private func getData() async throws -> [Product] {
    do {
      let data = try await networkStore.fetchEntries()
      print("Data loaded from network.")
      return data
    } catch {
      throw error
    }
  }


  private func getCategoriesData() async throws -> [String] {
    if let data = try? await networkStore.fetchCategories() {
      print("Data loaded from network.")
      return data
    }
    throw AppError.urlError
  }
}


extension ProductsViewModel {
  enum State {
    case initial

    case success(data: [Product])

    case successString(data: [String])

    case failed(error: Error)
  }
}


enum AppError: LocalizedError {
  case urlError
  case statusCodeError
  case decodingError
  case emptyDataError

  var errorDescription: String? {
    switch self {
    case .urlError:
      return "Invalid URL endpoint."
    case .statusCodeError:
      return "Server returned an error."
    case .decodingError:
      return "Data decoding failed."
    case .emptyDataError:
      return "No data found."
    }
  }
}
