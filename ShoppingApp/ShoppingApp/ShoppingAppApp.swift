//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/10/23.
//

import SwiftUI

@main
struct ShoppingAppApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(CartViewModel())
        .environmentObject(OrderViewModel())
        .environmentObject(WishlistViewModel())
        .environmentObject(OrderViewModel())
    }
  }
}
