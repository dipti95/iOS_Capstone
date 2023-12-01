//
//  Constant.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/26/23.
//

import Foundation

enum Constants {
  enum PaymentType: String, CaseIterable {
    case creditCard
    case debitCard
    case applePay
    case payPal
    var displayName: String {
      switch self {
      case .creditCard: return "Credit Card"
      case .debitCard: return "Debit Card"
      case .applePay: return "Apple Pay"
      case .payPal: return "PayPal"
      }
    }
  }
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


struct OnboardingStep {
  var title: String
  var description: String
  var image: String
}
