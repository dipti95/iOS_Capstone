//
//  OrdersViews.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/24/23.
//

import SwiftUI

struct OrdersViews: View {
  @EnvironmentObject var orders: OrderViewModel
  var body: some View {
    NavigationStack {
      if orders.order.isEmpty {
        VStack {
          Image("emptyCartImage")
            .resizable()
            .scaledToFit()

          Text("No order Placed")
            .font(.system(size: 36, weight: .light, design: .rounded))
            .multilineTextAlignment(.center)
            .padding()
        }
      } else {
        List {
          ForEach(orders.order) { order in
            NavigationLink {
              OrderViewDetails(order: order)
            } label: {
              VStack {
                Text("Order \(String(order.id.uuidString.prefix(8)))")
                Text("TotalPrice: \(order.totalPrice)")
              }
            }
          }
        }
        .navigationTitle("Orders")
      }
    }
  }
}

#Preview {
  OrdersViews()
  .environmentObject(OrderViewModel())
}
