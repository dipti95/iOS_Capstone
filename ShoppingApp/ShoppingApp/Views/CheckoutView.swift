//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/22/23.
//

import SwiftUI

struct CheckoutView: View {
  @EnvironmentObject var cart: CartViewModel
  @EnvironmentObject var order: OrderViewModel
  private let paymentTypes = ["Credit Card", "Debit Card", "Apple Pay", "PayPal"]
  @State private var paymentType = "Credit Card"
  @State var showItemAdded = false
  @State private var displayCreditCardEntry = false
  @State private var cardNumber = ""
  @State private var email = ""
  @State private var password = ""
  @State private var showConfirmation = false
  @State private var carrotPointsEarnedFromOrder = 0
  @AppStorage("firstName") var firstName = ""
  @AppStorage("lastName") var lastName = ""
  @AppStorage("address") var address = ""
  @AppStorage("city") var city = ""


  var totalPrice: Double {
    return cart.productsInCart.reduce(0) { $0 + $1.price }
  }

  var body: some View {
    Form {
      Section("Payment") {
        Picker("Payment Type", selection: $paymentType) {
          ForEach(paymentTypes, id: \.self) {
            Text($0)
          }
        }

        if paymentType == "Credit Card" || paymentType == "Debit Card" {
          TextField("Card number", text: $cardNumber.animation())
        }
        if paymentType == "Apple Pay" || paymentType == "PayPal" {
          TextField("Email", text: $email.animation())
          TextField("Password", text: $password.animation())
        }
      }

      Section("Billing Information") {
        TextField("First Name", text: $firstName)
        TextField("Last Name", text: $lastName)
        TextField("Address", text: $address)
        TextField("City", text: $city)
      }

      Section("Total") {
        Text("Total Amount: $\(String(format: "%.2f", totalPrice))")
        Section {
          Button(action: checkout) {
            Text("Place Order")
              .bold()
              .foregroundColor(.white)
              .padding()
              .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
              .cornerRadius(20)
              .shadow(radius: 3)
          }
          .listRowBackground(Color.clear)
        }
      }
      .navigationTitle("Checkout")
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  private func checkout() {
    let totalPrice = cart.productsInCart.reduce(0) { $0 + $1.price }
    order.order.append(Order(orderItems: cart.productsInCart, totalPrice: totalPrice))
    cart.productsInCart = []
    showItemAdded.toggle()
  }
}

#Preview {
  CheckoutView()
  .environmentObject(CartViewModel())
  .environmentObject(OrderViewModel())
}
