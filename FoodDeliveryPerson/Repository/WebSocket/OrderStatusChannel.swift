//
//  OrderStatusChannel.swift
//  FoodOrder
//
//  Created by TTC on 18/3/25.
//

import Foundation
import Starscream
class OrderStatusChannel: WebSocketChannel {
    let destination = "/topic/orderStatus"
    let subscriptionId = "sub-0"
    
    func subscribe(using socket: WebSocket) {
        let subscribeFrame = """
        SUBSCRIBE
        id:\(subscriptionId)
        destination:\(destination)

        \0
        """
        socket.write(string: subscribeFrame)
    }
    
    func handleMessage(_ message: String) {
        if let range = message.range(of: #"\{.*\}"#, options: .regularExpression),
           let data = message[range].data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let update = try decoder.decode(OrderUpdateStatus.self, from: data)
                DispatchQueue.main.async {
                    let userInfo: [String: OrderUpdateStatus] = ["updatedOrder": update]
                    NotificationCenter.default.post(name: .orderUpdated, object: nil, userInfo: userInfo)
                }
            } catch {
                print("Error decoding order status: \(error)")
            }
        }
    }
}

