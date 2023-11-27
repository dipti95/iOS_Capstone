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
    VStack {
      if wishlist.productsInWishlist.isEmpty {
        Image("shoppingBags")
          .resizable()
          .scaledToFit()

        Text("Product is not Selected in WishList")
          .font(.system(size: 36, weight: .light, design: .rounded))
          .multilineTextAlignment(.center)
          .padding()
      } else {
        Text("Wish List")
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.primary)
          .padding()
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
              VStack {
                Text("Title: \(product.title)")
                Text("Price \(product.price, format: .currency(code: "USD"))")
              }
            }
          }
          .onDelete(perform: deleteProductItems)
        }
      }
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
