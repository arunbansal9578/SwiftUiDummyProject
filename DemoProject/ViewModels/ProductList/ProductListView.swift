//
//  ProductListView.swift
//  DemoProject
//
//  Created by Arun Kumar  on 12/06/25.
//


import SwiftUI

struct ProductListView: View {
    
    @StateObject var viewModel = ProductViewModel()
    @State var cartCount: Int = 0
    @State private var toast: Toast? = nil
    @State private var isCartOpen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.products) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        HStack(alignment: .top, spacing: 10) {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.title)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                // MARK: onDelete Of Product List If Needed
                //                .onDelete { indexSet in
                //                    viewModel.deleteProduct(at: indexSet)
                //                    toast = Toast(type: .success, title: "Item Deleted", message: "Item deleted successfully!")
                //                }
                .onAppear {
                    cartCount = CoreDataManager.shared.getSavedProductCount()
                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reload") {
                        viewModel.fetchProducts()
                        toast = Toast(type: .success, title: "Product Reloaded", message: "List Reloaded Successfully..!")
                    }
                }
                
                if cartCount > 0 {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cart \(cartCount)") {
                            isCartOpen = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isCartOpen) {
                CartScreen()
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
        .toastView(toast: $toast)
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProductListView()
                .previewLayout(.sizeThatFits)
        }
    }
}
