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
        static let userKey = "user"
    }
    
    @Published var user: UserResponse? {
        didSet {
            if let encoded = try? JSONEncoder().encode(user) {
                defaults.set(encoded, forKey: Keys.userKey)
            } else {
                defaults.removeObject(forKey: Keys.userKey)
            }
        }
    }
  
    
    init() {
        // Khởi tạo từ UserDefaults
        if let data = defaults.data(forKey: Keys.userKey),
           let savedUser = try? JSONDecoder().decode(UserResponse.self, from: data) {
            self.user = savedUser
        } else {
            self.user = nil
        }
    }
    
 
    func saveUser(_ deliverPerson : DeliveryPersonResponse){
        self.user = UserResponse(id: deliverPerson.id ?? -1, username: deliverPerson.username)
        
        
    }
    
    func clear() {
        self.user = nil
    }
}
