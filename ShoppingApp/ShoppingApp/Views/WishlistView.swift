//
//  WishlistView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/14/23.
//

import SwiftUI

struct WishlistView: View {
  @EnvironmentObject var wishlist: WishlistViewModel

  var body: some View {
    NavigationView {
      VStack {
        if wishlist.productsInWishlist.isEmpty {
          VStack {
            Image("shoppingBags")
              .resizable()
              .scaledToFit()

            Text("Product is not Selected in WishList")
              .font(.system(size: 36, weight: .light, design: .rounded))
              .multilineTextAlignment(.center)
              .padding()
          }
        } else {
          VStack {
            List {
              ForEach(wishlist.productsInWishlist, id: \.self) { product in
                HStack {
                  AsyncImage(
                    url: product.thumbnail,
                    content: { image in
                      image.resizable()
                        .aspectRatio(contentMode: .fit)
                    },
                    placeholder: {
                      ProgressView()
                    }
                  )

                  Spacer()
                  Text(product.title)

                  Spacer()

                  Text("$\(String(format: "%.2f", product.price))")

                  Spacer()
                }
              }
              .onDelete(perform: deleteProductItems)
            }
          }
        }
      }
      .navigationTitle("Wish List")
    }
  }
  func deleteProductItems(at offsets: IndexSet) {
    wishlist.productsInWishlist.remove(atOffsets: offsets)
  }
}

#Preview {
  WishlistView()
  .environmentObject(WishlistViewModel())
}
