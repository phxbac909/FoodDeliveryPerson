//
//  ShopAPIClient.swift
//  FoodOrder
//
//  Created by TTC on 6/3/25.
//


import Foundation

class ShopAPIClient {
    private let baseURL = Config.serverIP + "/shops" // Thay bằng URL thực tế của bạn
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Upload Image
    func uploadImage(forShopId id: Int64, imageData: Data) async throws  {
        let url = URL(string: "\(baseURL)/uploadImage/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Tạo boundary cho multipart form-data
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Tạo body cho multipart form-data
        var body = Data()
        
        // Thêm phần file vào body
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"shop_\(id).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Kết thúc boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Gửi yêu cầu
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
//        return String(decoding: data, as: UTF8.self)
    }
    
    // MARK: - Create Shop
    func createShop(shop: Shop) async throws -> Shop {
        let url = URL(string: "\(baseURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(shop)
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(Shop.self, from: data)
    }
    
    // MARK: - Get All Shops
    func getAllShops() async throws -> [Shop] {
        let url = URL(string: "\(baseURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode([Shop].self, from: data)
    }
    
    // MARK: - Get Shop by ID
    func getShopById(id: Int64) async throws -> Shop {
        let url = URL(string: "\(baseURL)/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(Shop.self, from: data)
    }
    
    // MARK: - Update Shop
    func updateShop(id: Int64, shopDetails: Shop) async throws -> Shop {
        let url = URL(string: "\(baseURL)/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(shopDetails)
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(Shop.self, from: data)
    }
    
    // MARK: - Delete Shop
    func deleteShop(id: Int64) async throws {
        let url = URL(string: "\(baseURL)/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await session.data(for: request)
        try validateResponse(response)
    }  // MARK: - Login
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
    func register(shopRequest: ShopRequest) async throws -> UserResponse{
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(shopRequest)
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        let decoder = JSONDecoder()
        return try decoder.decode(UserResponse.self, from: data)
    }
    
    // MARK: - Helper Methods
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 400:
            throw APIError.badRequest
        case 404:
            throw APIError.notFound
        default:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    private func createMultipartFormData(boundary: String, imageData: Data, fieldName: String) -> Data {
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

