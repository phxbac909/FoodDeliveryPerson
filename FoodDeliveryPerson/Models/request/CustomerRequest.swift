//
//  CustomerRequestDto.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//


struct CustomerRequest: Codable {
    let username: String
    let password: String
    let fullName : String
    // Thêm các trường khác nếu cần (email, name, v.v.)
}

