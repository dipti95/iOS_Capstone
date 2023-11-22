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
      if wishlist.productsInWishlist.isEmpty {
        VStack {
          Image("emptyCartImage")
            .resizable()
            .scaledToFit()

          Text("No WishList Selected")
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
          }
          .navigationTitle("Cart")
        }
      }
    }
  }
}

#Preview {
  WishlistView()
  .environmentObject(WishlistViewModel())
}
