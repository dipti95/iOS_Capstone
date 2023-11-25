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
  @State private var cardNumber = ""
  @State private var email = ""
  @State private var password = ""
  @AppStorage("firstName")
  var firstName = ""

  @AppStorage("lastName")
  var lastName = ""

  @AppStorage("address")
  var address = ""

  @AppStorage("city")
  var city = ""

  var totalPrice: Double {
    cart.productsInCart.reduce(0) { $0 + $1.price }
  }

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 20) {
          paymentTypeSection
          billingInformationSection
          totalSection
        }
        .padding()
      }
      .navigationTitle("Checkout")
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  var paymentTypeSection: some View {
    GroupBox(label: Label("Payment", systemImage: "creditcard")) {
      Picker("Payment Type", selection: $paymentType) {
        ForEach(paymentTypes, id: \.self, content: Text.init)
      }
      .pickerStyle(SegmentedPickerStyle())

      if paymentType == "Credit Card" || paymentType == "Debit Card" {
        TextField("Card number", text: $cardNumber)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
      } else {
        TextField("Email", text: $email)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
        SecureField("Password", text: $password)
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(8)
      }
    }
  }

  var billingInformationSection: some View {
    GroupBox(label: Label("Billing Information", systemImage: "person.crop.circle")) {
      TextField("First Name", text: $firstName)

      TextField("Last Name", text: $lastName)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
      TextField("Address", text: $address)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
      TextField("City", text: $city)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
  }

  var totalSection: some View {
    VStack(alignment: .center, spacing: 10) {
      Text("Total Amount: $\(totalPrice, specifier: "%.2f")")
        .font(.title2)
      Button(action: checkout) {
        Text("Place Order")
          .bold()
          .foregroundColor(.white)
          .padding()
          .background(
            LinearGradient(
              gradient: Gradient(
                colors: [
                  Color.blue,
                  Color.purple
                ]
              ),
              startPoint: .leading,
              endPoint: .trailing
            )
          )
          .cornerRadius(20)
          .shadow(radius: 3)
      }
      .frame(maxWidth: .infinity)
      .listRowBackground(Color.clear)
    }
    .padding()
    .background(Color(.systemGray5))
    .cornerRadius(12)
  }

  private func checkout() {
    let totalPrice = cart.productsInCart.reduce(0) { $0 + $1.price }
    order.order.append(Order(orderItems: cart.productsInCart, totalPrice: totalPrice))
    cart.productsInCart = []
  }
}

#Preview {
  CheckoutView()
  .environmentObject(CartViewModel())
  .environmentObject(OrderViewModel())
}
