//
//  CartView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/13/23.
//

import SwiftUI

struct CartView: View {
  @EnvironmentObject var cart: CartViewModel
  @EnvironmentObject var orders: OrderViewModel
  @State var showItemAdded = false
  @State private var navigationPath = NavigationPath()

  var body: some View {
    NavigationStack(path: $navigationPath) {
      if cart.productsInCart.isEmpty {
        Image("emptyCartImage")
          .resizable()
          .scaledToFit()
          .padding()
          .overlay {
            Text("Cart is empty")
              .font(.system(size: 36, weight: .light, design: .rounded))
              .multilineTextAlignment(.center)
              .fontWeight(.bold)
              .foregroundColor(.white)
          }
      } else {
        VStack {
          let totalPrice = cart.productsInCart.reduce(0) { $0 + $1.price }
          List {
            ForEach(cart.productsInCart, id: \.self) { product in
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
            Text("Total: $\(String(format: "%.2f", totalPrice))")
            NavigationLink {
              CheckoutView()
            } label: {
              Text("Checkout")
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(
                  LinearGradient(
                    gradient: Gradient(
                      colors:
                        [Color.blue, Color.purple]),
                    startPoint: .leading,
                    endPoint: .trailing))
                .cornerRadius(20)
                .shadow(radius: 3)
            }
            .disabled(cart.productsInCart.isEmpty)
          }

          .navigationTitle("Cart")
        }
      }
    }
  }

  private func checkout() {
    let totalPrice = cart.productsInCart.reduce(0) { $0 + $1.price }
    orders.order.append(Order(orderItems: cart.productsInCart, totalPrice: totalPrice))
    cart.productsInCart = []
    showItemAdded.toggle()
  }
}

#Preview {
  CartView()
  .environmentObject(CartViewModel())
  .environmentObject(OrderViewModel())
}
