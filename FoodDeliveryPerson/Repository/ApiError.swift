//
//  APIError.swift
//  FoodOrder
//
//  Created by TTC on 6/3/25.
//


enum APIError: Error {
    case invalidResponse
    case badRequest
    case notFound
    case serverError(statusCode: Int)
    case conflict
    case noContent
}
