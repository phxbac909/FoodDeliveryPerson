//
//  OrderStatus.swift
//  FoodOrder
//
//  Created by TTC on 9/3/25.
//

import SwiftUICore


enum OrderStatus : String, Codable, CaseIterable {
    case DONE = "DONE"
    case PROCESSING = "PROCESSING"
    case CONFIRMED = "CONFIRMED"
    case SHIPPING = "SHIPPING"
    case SHIP_SUCCESS = "SHIP_SUCCESS"
    case CANCELED = "CANCELED"
    
    var badgeColor: Color? {
           switch self {
           case .PROCESSING:
               return .orange
           case .SHIPPING:
               return .teal
           case .CONFIRMED :
               return .green
           case .SHIP_SUCCESS :
               return .blue
           case .DONE, .CANCELED:
               return nil
           }
       }
    
    var title: String {
        switch self {
        case .DONE:
            "Done"
        case .PROCESSING:
            "Processing"
        case .CANCELED:
            "Canceled"
        case .SHIPPING:
            "Shipping"
        case .CONFIRMED:
            "Confirmed"
        case .SHIP_SUCCESS:
            "Ship Success"
        }
    }
}
