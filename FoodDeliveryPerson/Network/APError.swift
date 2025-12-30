//
//  APError.swift
//  FoodOrder
//
//  Created by TTC on 3/3/25.
//

import Foundation

enum APError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToCompleted
    
    var alertItem : AlertItem {
        switch self {
        case .invalidURL : return AlertItem(title: "Sever Error", message: "Please check connection")
        case .invalidData : return AlertItem(title: "Sever Error", message: "Please check connection")
        case .invalidResponse : return AlertItem(title: "Sever Error", message: "Please check connection")
        case .unableToCompleted : return AlertItem(title: "Sever Error", message: "Please check connection")
        }
    }
}

struct AlertItem : Identifiable {
    var id : UUID = UUID()
    var title : String
    var message : String
}
