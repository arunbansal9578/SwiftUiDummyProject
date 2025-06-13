//
//  ProductResponse.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//

import Foundation

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let stock: Int
    
}


 
