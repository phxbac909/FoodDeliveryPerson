//
//  DeliveryPersonListHistoryOrderViewModel.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//


import Foundation
import SwiftUICore
import Combine

class DeliveryPersonListHistoryOrderViewModel : ObservableObject {
    
    @StateObject private var userData = UserData.shared
    let orderRepository = OrderRepository()
    
    private var cancellables = Set<AnyCancellable>()

    @Published var doneOrder : [OrderDto] = []
    @Published var cancelOrder : [OrderDto] = []
    @Published var isLoading : Bool = false
    @Published var mockListOrder : [OrderDto] = [
        OrderDto(id: 1, customer: OrderDto.Customer(id: 1, fullName: "HaiNgonese"), shop: OrderDto.Shop(id: 1, name: "Ramua", distance: "4.5 km", address: "120 Yen Lang"), items: [], time: 0, status: .CONFIRMED, rating: 0)
    ]

    
    init(){
        NotificationCenter.default.publisher(for: .orderUpdated)
            .sink { [weak self] notification in
                Task { @MainActor in
                    if let updatedOrder = notification.userInfo?["updatedOrder"] as? OrderUpdateStatus {
                        if  updatedOrder.deliveryPersonId == self?.userData.user?.id {
                                await self?.loadListOrder();
                        }
                       
                       
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    
    func loadListOrder() async{
        do {
            self.doneOrder = try await orderRepository.getOrderByDeliveryPersonIdAndStatus(deliveryPersonId: userData.user?.id ?? -1, orderStatus: "DONE")
            self.cancelOrder = try await orderRepository.getOrderByDeliveryPersonIdAndStatus(deliveryPersonId: userData.user?.id ?? -1, orderStatus: "CANCELED")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateOrderStatus(id : Int64, status : OrderStatus) async {
        
        let orderStatus = OrderStatusRequest(status: status)
                
            do {
                try await orderRepository.updateOrderStatus(orderId: id, status: orderStatus)
            } catch ApiError.badRequest {
               print("Bad request")
            } catch ApiError.serverError(let statusCode) {
                print("Server error: \(statusCode)")
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
            }
            
        }
}
