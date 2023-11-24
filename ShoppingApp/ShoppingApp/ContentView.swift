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
                                        Label("Products", systemImage: "list.bullet.circle")
                                    }

                                AllProductView(viewModel: ProductsViewModel())
                                    .tabItem {
                                        Label("All Products", systemImage: "list.bullet.circle")
                                    }

                                CartView()
                                    .tabItem {
                                        Label("Cart", systemImage: "cart.fill")
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
            .fontWeight(.bold) // Adjust the weight as needed
            .foregroundColor(.clear) // Set foreground color to clear
            .background(
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
                    .mask(
                        Text(title)
                            .font(.largeTitle) // Ensure this font matches the outer Text view
                            .fontWeight(.bold) // Match the weight as well
                    )
            )
    }
}

#Preview {
  ContentView()
    .environmentObject(CartViewModel())
    .environmentObject(WishlistViewModel())
}
