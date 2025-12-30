//
//  Extension.swift
//  FoodOrder
//
//  Created by TTC on 5/3/25.
//

import SwiftUI

extension Color {
    static let brandPrimaryColor = Color("brandPrimary_")
}

extension Notification.Name {
    static let orderUpdated = Notification.Name("orderUpdated")
    static let newOrderReceived = Notification.Name("newOrderReceived")
}
