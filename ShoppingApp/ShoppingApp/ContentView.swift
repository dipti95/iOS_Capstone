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
            Label("Products", systemImage: "list.dash")
          }
        CartView()
          .tabItem {
            Label("Cart", systemImage: "list.dash")
          }
        WishlistView()
          .tabItem {
            Label("Wishlist", systemImage: "list.dash")
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
