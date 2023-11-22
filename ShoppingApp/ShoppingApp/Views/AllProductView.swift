//
//  AllProductView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/11/23.
//

import SwiftUI

struct AllProductView: View {
  @ObservedObject var viewModel: ProductsViewModel

  let columns = [
          GridItem(.flexible(), spacing: 20),
          GridItem(.flexible(), spacing: 20)
      ]


  var body: some View {
    NavigationStack {
      ZStack {
        switch viewModel.state {
        case .success(let data):
          ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
              ForEach(data, id: \.id) { product in
                NavigationLink(destination: DetailProductView(product: product)) {
                  VStack {
                    AsyncImage(url: product.thumbnail) { image in
                      image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    } placeholder: {
                      ProgressView()
                    }
                    .frame(width: 150, height: 150) // Adjust the frame width and height as needed
                    .cornerRadius(10)
                    Text("Price: \(product.price)") // Formatted price
                    Text("Brand: \(product.brand)")
                  }

                }
              }
              .border(Color.gray)
            }
            .padding()
          }
          .navigationTitle("Products")

        case .failed(let error):
          ErrorView(error: error)

        default:
          ProgressView()
        }
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
