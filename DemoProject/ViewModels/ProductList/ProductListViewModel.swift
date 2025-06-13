//
//  ProductListViewModel.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//

import Foundation
import CoreData
import UIKit
import SwiftUICore

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received.")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                DispatchQueue.main.async {
                    self.products = decodedResponse.products.reversed()
                }
            } catch {
                print("❌ Decoding error: \(error)")
            }
        }.resume()
    }
    
    func deleteProduct(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
    
    static func saveProductToCoreData(_ product: Product) -> Bool {
        let context = CoreDataManager.shared.context
        
        let newItem = ProductDetails(context: context)  
        newItem.id = Int64(product.id)
        newItem.title = product.title
        newItem.descriptions = product.description
        newItem.price = product.price
        newItem.thumbnail = product.thumbnail
        do {
            try context.save()
            print("✅ Product saved to Core Data.")
            return true
        } catch {
            print("❌ Failed to save product: \(error)")
            return false
        }
    }
    
}
