//
//  CartScreen.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//


import SwiftUI

struct CartScreen: View {
    
    @StateObject private var viewModel = CartScreenViewModel()
    @State private var toast: Toast? = nil
    @State private var goToConfirmation = false
    
    var totalPrice: Double {
        viewModel.products.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.products.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image("ic_emptyCart") // You can replace this with your custom image name
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray.opacity(0.6))
                        
                        Text("Your cart is empty.")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.products.indices, id: \.self) { index in
                            let item = viewModel.products[index]
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: item.thumbnail)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 80)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text(item.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text(String(format: "$%.2f", item.price))
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { indexSet in
                            viewModel.deleteProduct(at: indexSet)
                            toast = Toast(type: .success, title: "Item Deleted", message: "Item deleted successfully from Cart!")
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    HStack {
                        Text("Net Payable")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text(String(format: "$%.2f", totalPrice))
                            .font(.title3)
                            .bold()
                    }
                    .padding([.horizontal, .top])
                    
                    Button(action: {
                        withAnimation {
                            viewModel.clearAllProducts()
                            goToConfirmation = true
                        }
                    }) {
                        Text("Check out")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .navigationDestination(isPresented: $goToConfirmation) {
                        OrderConfirmation(isPresented: $goToConfirmation)
                    }
                }
            }
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchSavedProducts()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if totalPrice != 0 {
                        Button("Clear Cart") {
                            viewModel.clearAllProducts()
                            toast = Toast(type: .success, title: "All Products Deleted", message: "All Products Deleted Successfully..!")
                        }
                    }
                }
            }
        }
        .toastView(toast: $toast)
    }
}






