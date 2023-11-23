//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/10/23.
//

import SwiftUI

struct ContentView: View {


  @State private var isActive = true
  var body: some View {
    Group {
      if isActive {
        LaunchView()
      } else {
        VStack {
          TabView {
            CategoryView(viewModel: ProductsViewModel())
              .tabItem {
                Label("Products", systemImage: "list.bullet.circle")
              }
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
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        withAnimation {
          self.isActive = false
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
