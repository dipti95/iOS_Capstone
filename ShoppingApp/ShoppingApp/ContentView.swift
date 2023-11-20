//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/10/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      TabView {
        AllProductView(viewModel: ProductsViewModel())
          .tabItem {
            Label("Products", systemImage: "list.bullet.circle")
          }
        CartView()
          .tabItem {
            Label("Cart", systemImage: "cart.fill")
          }
        WishlistView()
          .tabItem {
            Label("Wishlist", systemImage: "heart.circle")
          }
      }
    }
  }
}

#Preview {
  ContentView()
    .environmentObject(CartViewModel())
    .environmentObject(WishlistViewModel())
}
