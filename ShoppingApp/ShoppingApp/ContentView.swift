//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/10/23.
//

import SwiftUI

struct ContentView: View {
  let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

  @State private var isActive = true
  var body: some View {
    NavigationView {
      Group {
        if isActive {
          LaunchView()
        } else {
          VStack {
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
              MyAccountView()
                .tabItem {
                  Label("Account", systemImage: "person.crop.circle.fill")
                }
            }
            .navigationBarItems(leading: GradientTitleView(title: "VelvetVibe", colors: colors))
            .navigationBarItems(trailing:
              NavigationLink(destination: WishlistView()) {
              Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundColor(.red)
        }
          )
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

struct GradientTitleView: View {
  var title: String
  var colors: [Color]

  var body: some View {
    Text(title)
      .font(.system(size: 40, weight: .bold, design: .rounded))
      .fontWeight(.bold)
      .foregroundColor(.clear)
      .background(
        LinearGradient(
          gradient: Gradient(colors: colors),
          startPoint: .leading,
          endPoint: .trailing
        )
        .mask(
          Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
        )
    )
  }
}

#Preview {
  ContentView()
    .environmentObject(CartViewModel())
    .environmentObject(WishlistViewModel())
    .environmentObject(OrderViewModel())
}
