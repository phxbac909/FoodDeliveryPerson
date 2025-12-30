import Foundation

//
//  Order 2.swift
//  FoodOrder
//
//  Created by TTC on 5/3/25.
//


struct Shop : Identifiable,Codable {
    let id: Int64
    let username: String
    let password: String
    let name: String
    let address: String
    let distance: String?
    let deliveryTime: String?
    let rating: Double?
    let discount: String?
}


