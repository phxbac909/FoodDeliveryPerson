//
//  MockData.swift
//  FoodOrder
//
//  Created by TTC on 5/3/25.
//

import Foundation

struct MockData {
    static let sampleShops: [Shop] = [
        Shop(
            id: 1,
            username: "pizzaHut",
            password: "securePass123",
            name: "Pizza Hut",
            address: "TkyoRe",
            distance: "2.5 km",
            deliveryTime: "30-40 min",
            rating: 4.5,
            discount: "10% off"
        ),
        Shop(
            id: 2,
            username: "burgerKing",
            password: "bkPass456",
            name: "Burger King",
            address: "HoaLac",
            distance: "1.8 km",
            deliveryTime: "25-35 min",
            rating: 4.2,
            discount: nil
        ),
        Shop(
            id: 3,
            username: "sushiMaster",
            password: "sushi789",
            name: "Sushi Master",
            address: "Shinashigai",
            distance: "3.0 km",
            deliveryTime: "40-50 min",
            rating: 4.8,
            discount: "Free delivery"
        )
    ]
    static let sampleFoods: [Food] = [
        Food(
            id: 1,
            name: "Pepperoni Pizza",
            description: "Classic pizza with pepperoni and mozzarella",
            price: 12.99,
            calories: 800,
            protein: 35,
            carbs: 90,
            tag: "Italian", shop: nil
        ),
        Food(
            id: 2,
            name: "Cheeseburger",
            description: "Juicy beef patty with cheddar cheese",
            price: 8.99,
            calories: 650,
            protein: 30,
            carbs: 45,
            tag: "American", shop: nil
        ),
        Food(
            id: 3,
            name: "California Roll",
            description: "Sushi roll with crab, avocado, and cucumber",
            price: 10.50,
            calories: 300,
            protein: 15,
            carbs: 40,
            tag: "Japanese", shop: nil
        ),
        Food(
            id: 4,
            name: "Margherita Pizza",
            description: "Fresh basil, tomato sauce, and mozzarella",
            price: 11.99,
            calories: 700,
            protein: 30,
            carbs: 85,
            tag: "Italian", shop: nil
        ),
        Food(
            id: 5,
            name: "Whopper",
            description: "Flame-grilled beef with fresh toppings",
            price: 9.99,
            calories: 700,
            protein: 35,
            carbs: 50,
            tag: "American", shop: nil
        )
    ]
    
    static let orderSample = OrderDto(id: 10,
                                      customer: OrderDto.Customer(id: 0, fullName: "User Alice"),
                                      shop: OrderDto.Shop(id: 1, name: "Chinese Food Traditional Error"),
                                      items: [
                                        OrderDto.OrderItem(id: 0, food: OrderDto.OrderItem.Food(id: 0, name: "Pizza", price: 4.99), quantity: 4),
                                        OrderDto.OrderItem(id: 1, food: OrderDto.OrderItem.Food(id: 1, name: "Hamberger", price: 7.00 ), quantity: 2),
                                        OrderDto.OrderItem(id: 2, food: OrderDto.OrderItem.Food(id: 2, name: "Bunbonuocleovitrasua", price: 10 ), quantity: 3
                                                        )],
                                      time: Date().timeIntervalSince1970,
                                      status: .SHIPPING,
                                      rating: 5
    )
  
}
