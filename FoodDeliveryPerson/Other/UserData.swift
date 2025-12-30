//
//  UserData.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//


import Foundation

class UserData: ObservableObject {
    static let shared = UserData()
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let userData = "customerData"
        static let userType = "userType"
    }
    
    @Published var user: UserResponse? {
        didSet {
            if let encoded = try? JSONEncoder().encode(user) {
                defaults.set(encoded, forKey: Keys.userData)
            } else {
                defaults.removeObject(forKey: Keys.userData)
            }
        }
    }
    @Published var isCustomer : Bool? {
        didSet {
            if let type = isCustomer  {
                defaults.set(type, forKey: Keys.userType)
            } else {
                defaults.removeObject(forKey: Keys.userType)
            }
        }
    }

    
    init() {
        // Khởi tạo từ UserDefaults
        if let data = defaults.data(forKey: Keys.userData),
           let savedCustomer = try? JSONDecoder().decode(UserResponse.self, from: data) {
            self.user = savedCustomer
        } else {
            self.user = nil
        }
        if defaults.object(forKey: Keys.userType) != nil {
            self.isCustomer = defaults.bool(forKey: Keys.userType)
        }
    }
    
    func saveCustomer(_ customer: UserResponse) {
        self.user = customer
        isCustomer = true
    }
    func saveShop(_ shop: UserResponse) {
        self.user = shop
        isCustomer = false
    }
    
    func clear() {
        self.user = nil
    }
}
