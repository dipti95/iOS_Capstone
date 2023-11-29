//
//  PlaceOrderAnimationView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/27/23.
//

import SwiftUI

struct PlaceOrderAnimationView: View {
  @State private var animateText = false

  var body: some View {
    Image("placeOrderImage")
      .resizable()
      .scaledToFill()
      .edgesIgnoringSafeArea(.all)
      .overlay(
        VStack {
          Spacer()
          Text("Order Placed!")
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .bold()
            .foregroundColor(.white)
            .scaleEffect(animateText ? 1.1 : 1.0)
            .opacity(animateText ? 1.0 : 0.0)
            .onAppear {
              withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                animateText.toggle()
              }
            }
          Spacer()
        }
      )
  }
}

#Preview {
  PlaceOrderAnimationView()
}
