//
//  LaunchViewModel.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/20/23.
//

import SwiftUI

extension String {
  func character(at index: Int) -> String {
    let stringIndex = self.index(self.startIndex, offsetBy: index)
    return String(self[stringIndex])
  }
}

struct LaunchView: View {
  let text = "VelvetVibe"
  let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
  @State private var animate = false
  var body: some View {
    Image("blackbagBackground")
      .resizable()
      .scaledToFill()
      .edgesIgnoringSafeArea(.all)
      .overlay {
        HStack(spacing: 0) {
          ForEach(0..<text.count, id: \.self) { index in
            Text(text.character(at: index))
              .font(.system(size: 40, weight: .bold, design: .rounded))
              .foregroundColor(self.animate ? colors[index % colors.count] : .white)
              .offset(y: self.animate ? -7 : 0)
              .scaleEffect(animate ? 1.0 : 0.1, anchor: .center)
              .rotationEffect(.degrees(animate ? 0 : 360))
              .opacity(animate ? 1 : 0)
              .animation(Animation.easeInOut(duration: 1).delay(0.1 * Double(index)), value: animate)
          }
        }
      }
      .onAppear {
        animate = true
      }
  }
}


#Preview {
  LaunchView()
}
