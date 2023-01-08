//
//  NetworkManager.swift
//  URLSession
//
//  Created by Денис Васильев on 05.01.2023.
//

import Foundation

enum Link: String {
    case categoryURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    case ingredientsURL = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
