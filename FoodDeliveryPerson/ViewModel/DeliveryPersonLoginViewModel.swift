//
//  DeliveryPersonLoginViewModel.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//

import Foundation

class DeliveryPersonLoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var fullName: String = ""
    @Published var password: String = ""
    @Published var isWrongAccount: Bool = false
    @Published var isDuplicateAcountName: Bool = false
    @Published var isLogging: Bool = false
    @Published var isSigning: Bool = false
    let authClient = DeliveryPersonRepository()
    
    func login() async {
        isLogging = true
        
        do {
            let deliveryPerson = try await authClient.login(username: username, password: password)
            if let deliveryPerson = deliveryPerson {
                isWrongAccount = false
                UserData.shared.saveUser(deliveryPerson)
                print(deliveryPerson)
                isLogging = false
            } else {
                print("Login failed: User not found")
            }
        } catch {
            isWrongAccount = true
        }
        isLogging = false
    }
    
    func register() async {
        isSigning = true
        let deliveryPersonRequest = DeliveryPersonRequest(username: username, password: password, fullName: fullName)
        do {
            let deliveryPerson = try await authClient.register(deliveryPersonRequest: deliveryPersonRequest)
            print(deliveryPerson)
            UserData.shared.saveUser(deliveryPerson)
            isSigning = false
        } catch ApiError.conflict {
            print("Duplicate account")
            isDuplicateAcountName = true
            isSigning = false
        } catch {
            print("Error: \(error.localizedDescription)")
            isSigning = false
        }
    }
}
