//
//  FoodDeliveryPersonApp.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//

import SwiftUI

@main
struct FoodDeliveryPersonApp: App {
   
    init(){
        _ = WebSocketManager.shared
    }
    

    var body: some Scene {
        WindowGroup {
            DeliveryPersonContentView()
        }
    }
}
