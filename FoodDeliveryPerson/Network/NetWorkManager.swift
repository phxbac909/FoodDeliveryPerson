//
//  NetWorkManager.swift
//  FoodOrder
//
//  Created by TTC on 3/3/25.
//

import Foundation
import UIKit

final class NetWorkManager {
    
//    static let shared = NetWorkManager()
//    
//    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
//    
//     let foodURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers"
//    private let cache = NSCache<NSString, UIImage>()
//    
//    private init() {}
//    
//    func getFoods(completed : @escaping(Result<[Food],APError>)->Void) {
//       
//        guard let url = URL(string: foodURL ) else {
//            completed(.failure(.invalidURL))
//            return
//        }
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
//            (data,response,error) in
//            if let _ = error  {
//                completed(.failure(.unableToCompleted))
//                return
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let res = try decoder.decode(FoodResponse.self, from: data)
//                completed(.success(res.request))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//        
//    }
//    
//    func getFoodsV2() async throws -> [Food] {
//        
//        guard let url = URL(string: foodURL) else {
//            throw APError.invalidURL
//        }
//        
//        let (data,_) = try await URLSession.shared.data(from: url)
//        
//        do {
//            return try JSONDecoder().decode(FoodResponse.self, from: data).request
//        }
//        catch {
//            throw APError.invalidData
//        }
//    }
//    
//    func getImage(urlString : String, completed : @escaping(UIImage?)->Void) {
//        
//        let cacheKey = NSString(string: urlString)
//        
//        if let image = cache.object(forKey: cacheKey) {
//            completed(image)
//            return
//        }
//        
//        guard let url = URL(string: urlString) else {
//            completed(nil)
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ (data,response,error) in
//    
//            guard let data = data ,  let image = UIImage(data: data) else {
//                completed(nil)
//                return
//            }
//            
//            self.cache.setObject(image, forKey: cacheKey)
//            completed(image)
//        }
//        
//        task.resume()
//    }
}
