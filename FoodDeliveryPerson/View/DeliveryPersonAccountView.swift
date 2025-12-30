//
//  DeliveryPersonAccountView.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//


import SwiftUI

struct DeliveryPersonAccountView: View {
    var body: some View {
        Button{
            UserData.shared.clear()
        } label: {
            Text("Log out \(UserData.shared.user?.username ?? "No User" ) ")
        }
    }
}

#Preview {
    DeliveryPersonAccountView()
}
