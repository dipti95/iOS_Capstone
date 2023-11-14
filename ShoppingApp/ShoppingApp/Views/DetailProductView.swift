//
//  DetailProductView.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/12/23.
//

import SwiftUI

struct DetailProductView: View {
  @EnvironmentObject var cart: CartViewModel
  @EnvironmentObject var wishlist: WishlistViewModel
  var product: Product
  @State private var currentImageIndex = 0
  @State var showItemAdded = false

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("Title: \(product.title)")
        .font(.title2)
        .bold()
      imageSection
      Text("Description:")
        .font(.headline)
      Text(product.description)

      Text("Rating: \(product.rating)")

      actionButtons
    }
    .padding(0)
  }

  private var imageSection: some View {
    VStack {
      if let imageUrl = product.images.indices.contains(currentImageIndex) ? product.images[currentImageIndex] : nil {
        AsyncImage(url: imageUrl) { image in
          image
            .resizable()
            .scaledToFit()
          Button(action: addToWishlist) {
            Text("Wishlist")
          }
        } placeholder: {
          ProgressView()
        }
        .frame(width: 300)
        .cornerRadius(10)
      } else {
        Text("No Image Available")
          .frame(width: 300)
          .background(Color.gray.opacity(0.2))
          .cornerRadius(10)
      }

      imageNavigationButtons
    }
  }

  private var imageNavigationButtons: some View {
    HStack {
      Button(action: previousImage) {
        Image(systemName: "arrow.backward.circle.fill")
          .font(.largeTitle)
          .foregroundColor(currentImageIndex == 0 ? .gray : .blue)
      }
      .disabled(currentImageIndex == 0)

      Spacer()

      Button(action: nextImage) {
        Image(systemName: "arrow.forward.circle.fill")
          .font(.largeTitle)
          .foregroundColor(currentImageIndex == product.images.count - 1 ? .gray : .blue)
      }
      .disabled(currentImageIndex == product.images.count - 1)
    }
  }

  private var actionButtons: some View {
    HStack {
      Button(action: addToCart) {
        Text("Add to Cart")
      }
      .alert("Added to Cart", isPresented: $showItemAdded) {
        // could add more button functionality here
        // or this could become a custom alert view like in Week 1 Bullseye Assignment
      } message: {
        Text("\(product.title)")
      }
    }
  }

  private func nextImage() {
    if currentImageIndex < product.images.count - 1 {
      withAnimation {
        currentImageIndex += 1
      }
    }
  }

  private func previousImage() {
    if currentImageIndex > 0 {
      withAnimation {
        currentImageIndex -= 1
      }
    }
  }

  private func addToWishlist() {
    wishlist.productsInWishlist.append(product)
    showItemAdded.toggle()
  }

  private func addToCart() {
    cart.productsInCart.append(product)
    showItemAdded.toggle()
  }
}

#Preview {
  DetailProductView(product: Product(
    id: 1,
    title: "iPhone 9",
    description: "An apple mobile which is nothing like apple",
    price: 549,
    discountPercentage: 12.96,
    rating: 4.69,
    stock: 94,
    brand: "Apple",
    category: "smartphones",
    thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")!,
    images: [
      URL(string: "https://i.dummyjson.com/data/products/1/1.jpg")!,
      URL(string: "https://i.dummyjson.com/data/products/1/2.jpg")!,
      URL(string: "https://i.dummyjson.com/data/products/1/3.jpg")!,
      URL(string: "https://i.dummyjson.com/data/products/1/4.jpg")!,
      URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")!
  ])
  )
  .environmentObject(CartViewModel())
  .environmentObject(WishlistViewModel())
}
