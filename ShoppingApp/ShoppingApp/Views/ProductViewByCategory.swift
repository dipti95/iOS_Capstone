//
//  ProductViewByCategory.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/22/23.
//

import SwiftUI

struct ProductViewByCategory: View {
  @State var category: String
  @StateObject var viewModel: ProductsViewModel

  var body: some View {
    NavigationStack {
      switch viewModel.state {
      case .success(let data):
        List(data.filter { $0.category == category }, id: \.self) { product in
          NavigationLink(destination: DetailProductView(product: product)) {
            VStack(alignment: .leading, spacing: 10) {
              AsyncImage(url: product.thumbnail) { image in
                image
                  .resizable()
                  .scaledToFit()
              } placeholder: {
                ProgressView()
              }
              .cornerRadius(10)
              .shadow(radius: 5)
              Text("\(product.price, format: .currency(code: "USD"))")
                .font(.headline)
                .foregroundColor(.primary)

              Text("Brand: \(product.brand)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding(.vertical)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
          }
        }
        .listStyle(PlainListStyle())
        .padding()

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
  ProductViewByCategory(category: "smartphones", viewModel: ProductsViewModel())
}
