//
//  ErrorView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/12/23.
//

import SwiftUI

struct ErrorView: View {
  let error: Error

  var body: some View {
    VStack(alignment: .center, spacing: 12) {
      Text("Ooops!")
        .font(.largeTitle)
        .bold()
      Text(error.localizedDescription)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
    .listRowSeparator(.hidden)
    .padding()
  }
}

#Preview {
  ErrorView(error: AppError.statusCodeError)
}
