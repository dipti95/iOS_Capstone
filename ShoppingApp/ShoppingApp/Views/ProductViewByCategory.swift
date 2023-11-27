//
//  ProductViewByCategory.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/22/23.
//

import SwiftUI

struct ProductViewByCategory: View {
  @State var category: String
  @State var products: [Product]

  var body: some View {
    NavigationStack {
      List(products.filter { $0.category == category }, id: \.self) { product in
        NavigationLink(destination: DetailProductView(product: product)) {
          VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: product.thumbnail) { image in
              image
                .resizable()
                .scaledToFit()
            } placeholder: {
              Image("placeholder")
                .resizable()
                .scaledToFit()
            }
            .cornerRadius(10)
            .shadow(radius: 5)
            Text("$\(String(format: "%.2f", Double(product.price)))")
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
    }
  }
}
