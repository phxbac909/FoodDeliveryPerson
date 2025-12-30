//
//  Customer.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//

import Foundation
struct Customer: Codable {
    let id: Int64
    let username: String
    let fullName : String
    // Thêm các trường khác nếu cần (email, name, v.v.)
}
