//
//  CartView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/13/23.
//

import SwiftUI

struct CartView: View {
  @EnvironmentObject var cart: CartViewModel
  @EnvironmentObject var order: OrderViewModel
  @State var showItemAdded = false

    var body: some View {
      NavigationView {
        if cart.productsInCart.isEmpty {
          VStack {
            Image("emptyCartImage")
              .resizable()
              .scaledToFit()

            Text("Your Shopping Cart is empty")
              .font(.system(size: 36, weight: .light, design: .rounded))
              .multilineTextAlignment(.center)
              .padding()
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

                  Spacer()
                  Text(product.title)

                  Spacer()

                  Text("$\(String(format: "%.2f", product.price))")

                  Spacer()
                }
              }
              Text("Total: $\(String(format: "%.2f", totalPrice))")
              Button(action: checkout) {
                Text("Checkout")
              }
              .alert("Added to Cart", isPresented: $showItemAdded) {
                // could add more button functionality here
                // or this could become a custom alert view like in Week 1 Bullseye Assignment
              } message: {
                Text("orderPlaced")
              }
            }

            .navigationTitle("Cart")
          }
        }
      }
    }

  private func checkout() {
    let totalPrice = cart.productsInCart.reduce(0) { $0 + $1.price }
    order.order.append(Order(orderItems: cart.productsInCart ,totalPrice: totalPrice))
    showItemAdded.toggle()
  }
}

#Preview {
  CartView()
  .environmentObject(CartViewModel())
  .environmentObject(OrderViewModel())
}
