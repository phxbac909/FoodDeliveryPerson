//
//  DeliveryPersonListOrderView.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//

import SwiftUI

// MARK: - DeliveryPersonListOrderView
struct DeliveryPersonListCurrentOrderView: View {
    @StateObject private var viewModel = DeliveryPersonListCurrentOrderViewModel()
 
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if let order = viewModel.shippingdOrder
                    {
                        DeliveryPersonOrderView(
                            order: order)
                    }
                    else {
                        ForEach(viewModel.confirmedOrder, id: \.id) { order in
                            DeliveryPersonOrderView(
                                order: order)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel.shippingdOrder == nil ? "Order avaiable" : "Current Order")
            .navigationBarTitleDisplayMode(.large)
        }.onAppear{
            Task{
                await viewModel.loadListOrder();
            }
        }
    }
}

// MARK: - Preview
struct DeliveryPersonListOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryPersonListCurrentOrderView()
    }
}
