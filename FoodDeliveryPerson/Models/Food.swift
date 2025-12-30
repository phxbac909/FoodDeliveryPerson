//
//  Food.swift
//  FoodOrder
//
//  Created by TTC on 3/3/25.
//

import Foundation
import UIKit
import SwiftUICore

struct Food : Codable, Identifiable {
    
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
    
    private var _imageUpdate: Bool?
    
        var imageUpdate: Bool {
            get { _imageUpdate ?? false }
            set { _imageUpdate = newValue }
        }
        
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case price
            case calories
            case protein
            case carbs
            case tag
            case shop
            case _imageUpdate = "imageUpdate" // Ánh xạ _imageUpdate với khóa imageUpdate trong JSON
        }
    
    init(
            id: Int64? = nil,
            name: String,
            description: String,
            price: Double,
            calories: Double,
            protein: Double,
            carbs: Double,
            tag: String,
            shop: ShopDto? = nil,
            imageUpdate: Bool = false // Tham số imageUpdate với giá trị mặc định là false
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.price = price
            self.calories = calories
            self.protein = protein
            self.carbs = carbs
            self.tag = tag
            self.shop = shop
            self._imageUpdate = imageUpdate
        }
}


