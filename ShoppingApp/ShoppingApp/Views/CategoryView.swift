//
//  CategoryView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/22/23.
//

import SwiftUI

//struct CategoryView: View {
//    @ObservedObject var viewModel: ProductsViewModel
//    @State private var selectedCategory: String?
//    @State private var categories: Set<String> = []
//
//    let columns = [
//        GridItem(.flexible(), spacing: 20),
//        GridItem(.flexible(), spacing: 20)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                // Category Header
//                Text("CATEGORY")
//                    .font(.headline)
//                    .padding()
//
//                // Category Buttons
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 10) {
//                        ForEach(Array(categories), id: \.self) { category in
//                            CategoryButton(category: category, isSelected: selectedCategory == category) {
//                                selectedCategory = category
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//
//                // Products Grid
//                ScrollView {
//                  switch viewModel.state {
//                                      case .success(let products):
//                                          LazyVGrid(columns: columns, spacing: 20) {
//                                              ForEach(products.filter { selectedCategory == nil || $0.category == selectedCategory }, id: \.id) { product in
//                                                  NavigationLink(destination: DetailProductView(product: product)) {
//                                                      ProductView(product: product)
//                                                  }
//                                                  .buttonStyle(PlainButtonStyle())
//                                              }
//                                          }
//                        .padding()
//                    case .failed(let error):
//                        Text("Error: \(error.localizedDescription)")
//                    case .initial:
//                        ProgressView()
//                    }
//                }
//            }
//            .navigationTitle("Products")
//        }
//        .task {
//                await viewModel.getEntries()
//              extractCategories()
//            }
//
////        .onChange(of: viewModel.state) { _ in
////            extractCategories()
////        }
//    }
//
//    // Function to extract categories from the fetched products
//    private func extractCategories() {
//        if case .success(let products) = viewModel.state {
//            for product in products {
//                categories.insert(product.category)
//            }
//        }
//    }
//}
//
//// Define the CategoryButton as per your design
//struct CategoryButton: View {
//    let category: String
//    let isSelected: Bool
//    let action: () -> Void
//
//  var body: some View {
//    VStack{
//      Button(action: action) {
//        VStack {
//          // Category image
//          Image(systemName: "photo") // Replace with actual category image
//            .resizable()
//            .scaledToFit()
//            .frame(height: 60)
//          Text(category.uppercased()) // Category name
//            .font(.headline)
//          Text("SEE MORE") // Placeholder for further action
//            .font(.caption)
//          Text("UP TO 25%") // Placeholder for discount, replace with actual value
//            .font(.caption)
//            .foregroundColor(.blue)
//        }
//        .padding()
//        .frame(width: 120, height: 160)
//        .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
//        .foregroundColor(isSelected ? .white : .black)
//        .cornerRadius(10)
//      }
//    }
//  }
//}
//struct ProductView: View {
//    var product: Product
//
//    var body: some View {
//        VStack {
//            AsyncImage(url: product.thumbnail) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(width: 150, height: 150)
//            .cornerRadius(10)
//            Text("Price: \(product.price)")
//            Text("Brand: \(product.brand)")
//        }
//        .border(Color.gray)
//    }
//}
//


struct CategoryView: View {
  @ObservedObject var viewModel: ProductsViewModel
  @State var categories: [String] = []
  @State var products: [Product] = []

  let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]

//  var body: some View {
//    NavigationStack {
//      List(categories, id: \.self) { category in
//        NavigationLink {
//          ProductViewByCategory(category: category, products: $products)
//        } label: {
//          VStack {
//            Text(category)
//          }
//        }
//      }
//      .navigationTitle("Products")
//    }
//    .task {
//      await viewModel.getEntries()
//      extractCategories()
//    }
//  }
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
            .foregroundColor(Color(.white))
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
