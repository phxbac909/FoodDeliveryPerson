//
//  NewOrderChannel.swift
//  FoodOrder
//
//  Created by TTC on 18/3/25.
//

import Foundation
import Starscream


class NewOrderChannel: WebSocketChannel {
    let destination = "/topic/newOrder"
    let subscriptionId = "sub-1"
    
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
                let newOrder = try decoder.decode(OrderDto.self, from: data)
                DispatchQueue.main.async {
                    let userInfo: [String: OrderDto] = ["newOrder": newOrder]
                    NotificationCenter.default.post(name: .newOrderReceived, object: nil, userInfo: userInfo)
                }
            } catch {
                print("Error decoding new order: \(error)")
            }
        }
    }
}
