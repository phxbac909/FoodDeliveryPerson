//
//  DeliveryPersonContentView.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//


//
//  ContentView.swift
//  FoodOrder
//
//  Created by TTC on 3/3/25.
//

import SwiftUI

struct DeliveryPersonContentView: View {
    
    @EnvironmentObject var order : Order
    @StateObject private var userData = UserData.shared
    
    var body: some View {
        ZStack{
            if userData.user != nil{
                TabView{
                    DeliveryPersonListCurrentOrderView().tabItem{
                                Label("Order", systemImage: "list.bullet")
                            }
                    DeliveryPersonListHistoryOrderView().tabItem{
                        Label("History", systemImage: "truck.box.badge.clock")
                    }
                    DeliveryPersonAccountView().tabItem {
                        Label("Account", systemImage: "person")
                    }
                }
            }
            else {
                DeliveryPersonLoginView()
            }
        }
    .ignoresSafeArea()
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .backgroundStyle(.white)
    .accentColor(Color("brandPrimary_"))
    }
}

#Preview {
    DeliveryPersonContentView()
}
