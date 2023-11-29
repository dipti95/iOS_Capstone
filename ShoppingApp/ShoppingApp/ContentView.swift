//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/10/23.
//

import SwiftUI


struct ContentView: View {
  @State private var isActive = true

  @AppStorage("hasSeenOnboarding")
  var hasSeenOnboarding = false

  var body: some View {
    if hasSeenOnboarding == false {
      OnboardingView(isOnboardingActive: $hasSeenOnboarding)
    } else {
      NavigationView {
        if isActive {
          LaunchView()
        } else {
          AppNavigationView()
        }
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          withAnimation {
            self.isActive = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
    .environmentObject(CartViewModel())
    .environmentObject(WishlistViewModel())
    .environmentObject(OrderViewModel())
}
