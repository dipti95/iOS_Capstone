//
//  OrderViewDetails.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/24/23.
//

import SwiftUI

struct OrderViewDetails: View {
  @State var order: Order

  var body: some View {
    List {
      Text("Total Price: \(order.totalPrice, specifier: "%.2f")")

      ForEach(order.orderItems, id: \.self) { product in
        NavigationLink(destination: DetailProductView(product: product)) {
          AsyncImage(url: product.thumbnail) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 300, height: 200)
          .cornerRadius(10)
          .shadow(radius: 5)
        }
      }
    }
  }
}


#Preview {
  OrderViewDetails(order: (Order(id: UUID(), orderItems: [], totalPrice: 46.00)))
}
