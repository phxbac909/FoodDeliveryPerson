//
//  DeliveryPersonRepository.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//

import Foundation

class DeliveryPersonRepository {
    private let baseURL = Config.urlHTTP + "/delivery-person"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Login
    func login(username: String, password: String) async throws -> DeliveryPersonResponse? {
        let url = URL(string: "\(baseURL)/login/\(username)/\(password)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(DeliveryPersonResponse?.self, from: data)
    }
    
    // MARK: - Register
    func register(deliveryPersonRequest: DeliveryPersonRequest) async throws -> DeliveryPersonResponse {
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(deliveryPersonRequest)
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(DeliveryPersonResponse.self, from: data)
    }
    
    // MARK: - Helper Method
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 404:
            throw ApiError.notFound
        case 409:
            throw ApiError.conflict
        default:
            throw ApiError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    // MARK: - Assign Delivery Person to Order
    func assignToOrder(orderId: Int64, deliveryPersonId: Int64) async throws {
        let urlString = "\(baseURL)/\(orderId)/delivery-person/\(deliveryPersonId)"
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let (_, response) = try await session.data(for: request)
        try validateResponse(response)
        
    }
}
