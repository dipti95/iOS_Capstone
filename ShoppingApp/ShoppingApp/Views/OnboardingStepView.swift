//
//  OnboardingButton.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/30/23.
//

import SwiftUI

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

#Preview {
  OnboardingStepView(
    step: OnboardingStep(
      title: "Discover Latest Trends",
      description: "Explore a wide range of products from top brands across various categories.",
      image: "onboarding"
    )
  )
}
