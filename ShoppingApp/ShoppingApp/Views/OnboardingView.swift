//
//  OnboardingView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/27/23.
//

import SwiftUI

struct OnboardingStep {
  var title: String
  var description: String
  var image: String
}

let onlineShoppingOnboardingSteps: [OnboardingStep] = [
  OnboardingStep(
    title: "Discover Latest Trends",
    description: "Explore a wide range of products from top brands across various categories.",
    image: "onboarding"
  ),
  OnboardingStep(
    title: "Easy and Secure Payment",
    description: "Enjoy a safe shopping experience with multiple secure payment options.",
    image: "onboarding"
  ),
  OnboardingStep(
    title: "Exclusive Offers",
    description: "Get access to special discounts, deals, and loyalty rewards.",
    image: "onboarding"
  )
]


struct OnboardingStepView: View {
  var step: OnboardingStep

  var body: some View {
    Image(step.image)
      .resizable()
      .scaledToFill()
      .overlay(
        Text(step.title)
          .font(.title)
          .bold()
          .foregroundColor(.white)
      )
  }
}

struct OnboardingView: View {
  var steps: [OnboardingStep] = onlineShoppingOnboardingSteps
  @Binding var isOnboardingActive: Bool

  var body: some View {
    ZStack(alignment: .bottom) {
      TabView {
        ForEach(steps.indices, id: \.self) { index in
          OnboardingStepView(step: steps[index])
        }
      }
      .edgesIgnoringSafeArea(.all)
      .tabViewStyle(PageTabViewStyle())
      .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
      Button("Get Started") {
        isOnboardingActive = true
      }
      .buttonStyle(MyButtonStyle())
      .padding()
    }
  }
}


struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .foregroundColor(.white)
      .background(
        LinearGradient(
          gradient: Gradient(colors: [Color.pink, Color.blue, Color.green]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
      .cornerRadius(8)
      .overlay(configuration.isPressed ? Color.white.opacity(0.2) : Color.clear)
  }
}


#Preview {
  OnboardingView( isOnboardingActive: .constant(true))
}
