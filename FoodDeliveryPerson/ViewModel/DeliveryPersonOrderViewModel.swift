//
//  DeliveryPersonOrderViewModel.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//

import Foundation

class DeliveryPersonOrderViewModel : ObservableObject {
    
    let orderRepository = OrderRepository()
    
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
    
    func assginOrderToDeliveryPerson(id : Int64,deliveryPersonId: Int64) async {
        do {
            try await orderRepository.assignDeliveryPersonToOrder(orderId: id, deliveryPersonId: deliveryPersonId)
        } catch ApiError.badRequest {
            print("Bad request")
        } catch ApiError.serverError(let statusCode) {
            print("Server error: \(statusCode)")
        } catch {
            
        }
    }
}
