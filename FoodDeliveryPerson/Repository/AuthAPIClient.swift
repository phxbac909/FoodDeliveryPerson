//
//  AuthAPIClient.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//


import Foundation

class AuthAPIClient {
    private let baseURL =  Config.serverIP + "/auth"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Login
    func login(username: String, password: String) async throws -> UserResponse? {
        let url = URL(string: "\(baseURL)/login/\(username)/\(password)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(UserResponse?.self, from: data)
    }
    
    // MARK: - Register
    func register(customerRequest: CustomerRequest) async throws -> UserResponse{
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(customerRequest)
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(UserResponse.self, from: data)
    }
    
    // MARK: - Helper Method
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 404:
            throw APIError.notFound
        case 409:
            throw APIError.conflict
        default:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}

