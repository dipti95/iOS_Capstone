//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/10/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      AllProductView(viewModel: ProductsViewModel())
    }
  }
}

#Preview {
  ContentView()
}
