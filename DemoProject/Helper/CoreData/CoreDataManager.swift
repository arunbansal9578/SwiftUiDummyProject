//
//  CodeDataShared.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ProductsData")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Failed to load Core Data: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Failed to save: \(error)")
        }
    }
    
    
    func getSavedProductCount() -> Int {
        let fetchRequest: NSFetchRequest<ProductDetails> = ProductDetails.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            print("❌ Failed to count products: \(error)")
            return 0
        }
    }
    
}
