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
  @State private var paymentType: PaymentType = .creditCard
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
    NavigationStack {
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
        ForEach(PaymentType.allCases, id: \.self) { type in
          Text(type.displayName).tag(type)
        }
      }
      .pickerStyle(SegmentedPickerStyle())

      if paymentType == .creditCard || paymentType == .debitCard {
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
        .padding()
      TextField("Last Name", text: $lastName)
        .padding()
      TextField("Address", text: $address)
        .padding()
      TextField("City", text: $city)
        .padding()
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
