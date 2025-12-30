//
//  LoginViewModel.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//

import Foundation

class ShopLoginViewModel : ObservableObject {
    
    @Published var username : String = ""
    @Published var fullName : String = ""
    @Published var password : String = ""
    @Published var isWrongAccount : Bool = false
    @Published var isDuplicateAcountName : Bool = false
    @Published var isLogging: Bool = false
    @Published var isSigning : Bool = false
    let authClient = ShopAPIClient()

    
    func login( ) async  {
        isLogging = true
        
        do {
            let shop = try await authClient.login(username: username, password: password)
            if let shop = shop {
                isWrongAccount = false
                UserData.shared.saveShop(shop)
                print(shop)
                isLogging = false
            } else {
                print("Login failed: User not found")
            }
        }  catch {
            isWrongAccount = true
        }
        isLogging = false
    }
    
    func register() async {
        isSigning = true
        let shopRequest = ShopRequest(username: username, password: password, name : fullName)
            do {
                let shop = try await authClient.register(shopRequest: shopRequest)
                print(shop)
                UserData.shared.saveShop(shop)
                isSigning = false
            } catch APIError.serverError(statusCode: 500) {
                print("error 500")
                isDuplicateAcountName = true
                isSigning = false
            } catch {
                print("Error: \(error.localizedDescription)")
                isSigning = false
            }
        }
}
