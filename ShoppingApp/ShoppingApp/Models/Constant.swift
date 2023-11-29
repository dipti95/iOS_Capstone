//
//  Constant.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/26/23.
//

import Foundation


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
