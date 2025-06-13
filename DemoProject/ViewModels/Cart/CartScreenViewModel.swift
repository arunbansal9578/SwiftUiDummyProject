//
//  CartScreenViewModel.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//


import CoreData
import SwiftUI

class CartScreenViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    func fetchSavedProducts() {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            self.products = entities.compactMap { entity in
                Product(
                    id: Int(entity.id),
                    title: entity.title ?? "",
                    description: entity.descriptions ?? "",
                    price: entity.price,
                    thumbnail: entity.thumbnail ?? "",
                    stock: 0
                )
            }
        } catch {
            print("❌ Failed to fetch products from Core Data: \(error)")
        }
    }
    
    func deleteProduct(at offsets: IndexSet) {
        let context = CoreDataManager.shared.context
        
        for index in offsets {
            let product = products[index]
            
            let fetchRequest: NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", product.id)
            
            do {
                let items = try context.fetch(fetchRequest)
                if let objectToDelete = items.first {
                    context.delete(objectToDelete)
                    try context.save()
                    print("✅ Deleted product with ID: \(product.id)")
                }
            } catch {
                print("❌ Error deleting product from Core Data: \(error)")
            }
        }
        
        products.remove(atOffsets: offsets)
    }
    
    func clearAllProducts() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ProductDetails.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            products.removeAll()
            print("✅ All products deleted from Core Data")
        } catch {
            print("❌ Failed to delete all products: \(error)")
        }
    }
    
}
