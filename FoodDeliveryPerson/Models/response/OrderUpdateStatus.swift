//
//  OrderUpdateStatus.swift
//  FoodOrder
//
//  Created by TTC on 18/3/25.
//


struct OrderUpdateStatus: Codable, Identifiable {
    let id : Int64
    var status: OrderStatus
    let deliveryPersonId: Int64?
}
