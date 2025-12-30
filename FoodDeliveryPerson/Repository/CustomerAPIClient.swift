//
//  CustomerAPIClient.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//

import Foundation

class CustomerAPIClient {
    
    private let baseURL = Config.urlHTTP + "/customer"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Upload Image
    func uploadImage(imageData: Data, forCustomerId id: Int64) async throws -> Void {
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
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"customer_\(id).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Kết thúc boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Gửi yêu cầu
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
    }
    
    // MARK: - Helper Method
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        print("Code :  \(httpResponse.statusCode)" )
    }
}
