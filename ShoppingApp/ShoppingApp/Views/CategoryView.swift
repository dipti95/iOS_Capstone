//
//  CategoryView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/22/23.
//

import SwiftUI

struct CategoryView: View {
  @ObservedObject var viewModel: ProductsViewModel
  @State var categories: [String] = []
  @State var products: [Product] = []

  let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]

  var body: some View {
    NavigationStack {
      List(categories, id: \.self) { category in
        NavigationLink {
          ProductViewByCategory(category: category, products: $products)
        }
      label: {
        HStack(spacing: 15) {
          Image("shoppingBags")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
            .padding(.leading, 5)
          Text(category.prefix(1).capitalized + category.dropFirst())
            .fontWeight(.bold)
            .foregroundColor(Color("categoryTextColor"))
            .shadow(radius: 10)

          Spacer()
        }
        .padding()
        .background(Color("categoryColor"))
        .cornerRadius(10)
        .shadow(radius: 5)
       }
      }
      .listStyle(.insetGrouped)
      .navigationTitle("Categories")
    }
    .task {
      await viewModel.getEntries()
      extractCategories()
    }
    .padding(.horizontal)
  }

  private func extractCategories() {
    if case .success(let allProducts) = viewModel.state {
      products = allProducts
        for product in allProducts {
          if(!categories.contains(product.category)) {
            categories.append(product.category)
          }
        }
      }
    }
}


#Preview {
  CategoryView(viewModel: ProductsViewModel())
}
