//
//  Order.swift
//  FoodOrder
//
//  Created by TTC on 4/3/25.
//

import Foundation
class Order : ObservableObject {
    
    @Published var items: [OrderItem]
        
    init() {
        self.items = []
    }
    
    func addItem(_ food: Food) {
        if let index = items.firstIndex(where: { $0.food.id == food.id }) {
            items[index].quantity += 1
        } else {
            items.append(OrderItem(id: food.id!, food: food, quantity: 1))
        }
    }
    func removeItem(_ food: Food) {
        guard let index = items.firstIndex(where: { $0.food.id == food.id }) else { return  }
            items[index].quantity -= 1
    }
    
    var totalPrice: Double {
        return items.reduce(0) { $0 + $1.food.price * Double($1.quantity)}
    }
    
    var total : Int {
        return items.reduce(0) { $0 + $1.quantity}
    }
}
struct OrderItem: Identifiable, Codable {
    let id: Int64
    let food: Food
    var quantity: Int
}


