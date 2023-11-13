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
    NavigationStack {
      switch viewModel.state {
      case .success(let data):
        List(data, id: \.id) { product in
          NavigationLink {
            DetailProductView(product: product)
          } label: {
            VStack {
              AsyncImage(url: product.thumbnail) { image in
                image
                  .resizable()
                  .scaledToFit()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 300)
              .cornerRadius(10)
              Text("Price: \(product.price)")
              Text("Brand: \(product.brand)")
            }
          }
        }
        .navigationTitle("Products")
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
