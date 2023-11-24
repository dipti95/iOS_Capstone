//
//  MyAccountView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/23/23.
//

import SwiftUI

struct MyAccountView: View {
  var body: some View {
    VStack{
      NavigationStack{
        Text("Hello Dipti")
        NavigationLink{
          Text("testing")
        }label: {
          Text("Your Orders")
            .bold()
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .shadow(radius: 3)

        }
        .navigationTitle("Your Account")
      }
    }
  }
}

#Preview {
  MyAccountView()
}
