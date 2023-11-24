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
  @State private var isInWishlist = false

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 10) {
        Text("Title: \(product.title)")
          .font(.title2)
          .bold()
          .padding(.horizontal)

        imageSection

        Text("Description:")
          .font(.headline)
          .padding(.horizontal)

        Text(product.description)
          .padding(.horizontal)

        Text("Rating: \(String(format: "%.2f", Double(product.rating)))")
          .padding(.horizontal)
        Text("Price: $\(String(format: "%.2f", Double(product.price)))")
          .padding(.horizontal)

        actionButtons
      }
      .padding(.bottom)
    }
  }

  private var imageSection: some View {
    VStack {
      if let imageUrl = product.images.indices.contains(currentImageIndex) ? product.images[currentImageIndex] : nil {
        AsyncImage(url: imageUrl) { image in
          image
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
              Button(action: addToWishlist) {
                Image(systemName: isInWishlist ? "heart.circle" : "heart.circle.fill")
                  .imageScale(.large)
                  .foregroundColor(.red)
              }
              .padding(16)
              , alignment: .topTrailing
            )
        } placeholder: {
           ProgressView()
        }
        .frame(height: 300)
        .padding(.horizontal)

        imageNavigationButtons
      } else {
        Text("No Image Available")
          .frame(height: 300)
          .background(Color.gray.opacity(0.2))
          .cornerRadius(10)
          .padding(.horizontal)
      }
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
    .padding()
  }

    private var actionButtons: some View {
      HStack {
        Button(action: addToCart) {
          Text("Add to Cart")
            .bold()
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            .shadow(radius: 3)
        }
        .alert("Added to Cart", isPresented: $showItemAdded) {
        } message: {
          Text("\(product.title)")
        }
      }
      .padding(.horizontal)
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
      if(!wishlist.productsInWishlist.contains(product)){
        wishlist.productsInWishlist.append(product)
      }
      isInWishlist = true
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
    thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg"),
    images: [
      URL(string: "https://i.dummyjson.com/data/products/1/1.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/2.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/3.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/4.jpg"),
      URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")
    ]
  )
  )
  .environmentObject(CartViewModel())
  .environmentObject(WishlistViewModel())
}
