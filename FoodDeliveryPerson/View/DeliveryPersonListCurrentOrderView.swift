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
            ZStack{
                if let order = viewModel.shippingdOrder {
                    DeliveryPersonOrderView(
                        order: order)
                }
                else if(viewModel.confirmedOrder.count > 0) {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.confirmedOrder, id: \.id) { order in
                                DeliveryPersonOrderView(
                                    order: order)
                            }
                        }
                    }
                    .padding()
                }
                else {
                    Spacer()
                    EmptyOrderView()
                    Spacer()
                }
            }
            .navigationTitle( "Order Avaiable")
            .navigationBarTitleDisplayMode(.large)
            .onAppear{
                Task{
                    await viewModel.loadListOrder();
                }
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
