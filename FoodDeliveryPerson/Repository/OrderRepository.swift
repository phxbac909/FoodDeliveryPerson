//
//  OrderAPIClient.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//
import Foundation

class OrderRepository {
    private let baseURL = Config.urlHTTP +  "/orders"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func updateOrderStatus(orderId: Int64, status: OrderStatusRequest) async throws {
            let url = URL(string: "\(baseURL)/update/\(orderId)")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(status)
            
            let (data, response) = try await session.data(for: request)
            try validateResponse(response)
        }
    
    // MARK: - Create Order
    func createOrder(_ order: OrderDto) async throws -> OrderDto {
        let url = URL(string: "\(baseURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(order)
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        let decoder = JSONDecoder()
        return try decoder.decode(OrderDto.self, from: data)
    }
    
    // MARK: - Get Orders by CustomerId
    func getOrdersByCustomerId(_ customerId: Int64) async throws -> [OrderDto] {
        let url = URL(string: "\(baseURL)/customer/\(customerId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode([OrderDto].self, from: data)
    }
    
    // MARK: - Get Orders by ShopId
    func getOrdersByShopId(_ shopId: Int64) async throws -> [OrderDto] {
        let url = URL(string: "\(baseURL)/shop/\(shopId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode([OrderDto].self, from: data)
    }
    
    // MARK: - Helper Method
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
    }
    
    func getOrdersByStatus(orderStatus: String) async throws -> [OrderDto] {
//        let encodedStatus = orderStatus.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? /*orderStatus*/
        let urlString = "\(baseURL)/status/\(orderStatus)"
        
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode([OrderDto].self, from: data)
    }

    // MARK: - Get Order by Delivery Person ID and Status
    func getOrderByDeliveryPersonIdAndStatus(
        deliveryPersonId: Int64,
        orderStatus: String
    ) async throws -> [OrderDto] {
        
        let urlString = "\(baseURL)/delivery-person-id/\(deliveryPersonId)/status/\(orderStatus)"
        
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        let decoder = JSONDecoder()
        return try decoder.decode([OrderDto].self, from: data)
    }
    
    // MARK: - Assign Delivery Person to Order
    func assignDeliveryPersonToOrder(orderId: Int64, deliveryPersonId: Int64) async throws {
        let urlString = "\(baseURL)/\(orderId)/delivery-person/\(deliveryPersonId)"
        
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        // Không cần Content-Type vì không có body
        
        let (_, response) = try await session.data(for: request)
        try validateResponse(response)
        
        // Không decode data vì response body rỗng (200 OK với Void)
    }

}
