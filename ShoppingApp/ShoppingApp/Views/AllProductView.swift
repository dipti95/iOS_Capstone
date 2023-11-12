//
//  AllProductView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import SwiftUI

struct AllProductView: View {
  @ObservedObject var viewModel: ProductsViewModel

  var body: some View {
    NavigationView {
      switch viewModel.state {
      case .success(let data):
        List(data, id: \.id) { entry in
          Text(entry.category)
        }
      case .failed(let error):
        ErrorView(error: error)
      default:
        ProgressView()
      }
    }
    .task {
      await viewModel.getEntries()
    }
  }
}

#Preview {
  AllProductView(viewModel: ProductsViewModel())
}
