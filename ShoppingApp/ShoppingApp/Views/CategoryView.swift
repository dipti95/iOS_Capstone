//
//  CategoryView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/22/23.
//

import SwiftUI

struct CategoryView: View {
  @StateObject var viewModel: ProductsViewModel
  @State var categories: [String] = []

  var body: some View {
    NavigationStack {
      switch viewModel.state {
      case .failed(let error):
        ErrorView(error: error)
      case .success(let data):
        List(categories, id: \.self) { category in
          NavigationLink {
            ProductViewByCategory(category: category, products: data)
          } label: {
            HStack(spacing: 15) {
              Image("shoppingBags")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .padding(.leading, 5)
              Text(category.capitalized)
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
      default:
        ProgressView()
      }
    }
    .task {
      await viewModel.getEntries()
      extractCategories()
    }
    .padding(.horizontal)
  }
  private func extractCategories() {
    if case .success(let allProducts) = viewModel.state {
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
