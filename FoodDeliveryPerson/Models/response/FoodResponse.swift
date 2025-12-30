//
//  FoodResponse.swift
//  FoodOrder
//
//  Created by TTC on 14/3/25.
//

import Foundation
import UIKit
import SwiftUICore

struct FoodResponse : Codable, Identifiable {
    
    var id: Int64?
    var name: String
    var description: String
    var price: Double
    var calories: Double
    var protein: Double
    var carbs: Double
    var tag: String
    var shop : ShopDto?
    
    struct ShopDto : Codable, Identifiable  {
        var id : Int64
    }
        
}
