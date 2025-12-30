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
            if let shop = userData.user{
//                TabView {
//                    ShopDetailView(shop: Shop(id: shop.id, username: "none", password: "none", name: "Milk Hunter", address: "Raumania Kingdom", distance: nil, deliveryTime: nil, rating: 4.5, discount: nil)).tabItem {
//                            Image(systemName: "fork.knife")
//                            Text("Your Shop")
//                        }
//                    ShopListOrderView().tabItem{
//                            Label("Order", systemImage: "cart")
//                        }
//                    ShopAccountView().tabItem {
//                        Label("Account", systemImage: "person")
//                    }
//                }
            }
            else {
                DeliveryPersonLoginView()
            }
        }
//    .ignoresSafeArea()
//    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//    .backgroundStyle(.white)
//    .accentColor(Color("brandPrimary_"))
    }
}

#Preview {
    ShopContentView()
}
