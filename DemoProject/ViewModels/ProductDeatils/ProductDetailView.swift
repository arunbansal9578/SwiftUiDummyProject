//
//  ProductDetailView.swift
//  DemoProject
//
//  Created by Arun Kumar  on 12/06/25.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 6) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 200)
                }
                
                Text(product.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Price: $\(String(format: "%.2f", product.price))")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Stock: \(product.stock) Left")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add To Cart") {
                    let success = ProductViewModel.saveProductToCoreData(product)
                    if success {
                        toast = Toast(type: .success, title: "Product Added", message: "Product added to cart successfully!")
                    } else {
                        toast = Toast(type: .error, title: "Cart Error", message: "Unable to add product to cart!")
                    }
                }
            }
        }
        .toastView(toast: $toast)
    }
}
