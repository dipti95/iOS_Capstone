//
//  AppNavigationView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/26/23.
//

import SwiftUI

struct AppNavigationView: View {
  let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    var body: some View {
      TabView {
        CategoryView(viewModel: ProductsViewModel())
          .tabItem {
            Label("Categories", systemImage: "list.bullet.circle")
          }

        AllProductView(viewModel: ProductsViewModel())
          .tabItem {
            Label("All Products", systemImage: "list.bullet.circle")
          }

        CartView()
          .tabItem {
            Label("Cart", systemImage: "cart.fill")
          }

        WishlistView()
          .tabItem {
            Label("WishList", systemImage: "heart.fill")
          }

        MyAccountView()
          .tabItem {
            Label("Account", systemImage: "person.crop.circle.fill")
          }
      }
  }
}

#Preview {
  AppNavigationView()
  .environmentObject(CartViewModel())
  .environmentObject(WishlistViewModel())
  .environmentObject(OrderViewModel())
}
