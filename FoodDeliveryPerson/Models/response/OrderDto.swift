//
//  OrderDto.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//


import Foundation



struct OrderDto: Codable, Identifiable {
   
    let id: Int64?
    let customer: Customer
    let shop: Shop
    var items: [OrderItem]
    let time : TimeInterval?
    var status: OrderStatus
    let rating : Double?
    
    struct Customer: Codable {
        let id: Int64
        let fullName: String
    }
    
    struct Shop: Codable {
        let id: Int64
        let name: String
        let distance: String
        let address: String
    
    }
    
    struct OrderItem: Codable, Identifiable {
        let id: Int64?
        let food: Food
        let quantity: Int
        
        struct Food: Codable, Identifiable {
            let id: Int64
            let name: String
            let price : Double
        }
    }

}
 

