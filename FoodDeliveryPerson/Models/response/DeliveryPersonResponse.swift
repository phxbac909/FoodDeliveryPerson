//
//  DeliveryPersonResponse.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//


struct DeliveryPersonResponse: Codable {
    let id: Int64? // Giả sử ID là Int64 trong Swift
    let username: String
    let fullName: String
}