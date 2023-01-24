//
//  NetworkManager.swift
//  URLSession
//
//  Created by Денис Васильев on 05.01.2023.
//

import Foundation
import Alamofire

// MARK: - Links
enum Link: String {
    case categoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    case mealsURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    case mealDetailURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
}

// MARK: - Errors
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

// MARK: - Class - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Метод для загрузки из сети данных типа Category.
    /// Ручной парсинг JSON
    func fetchCategories(from url: String, completion: @escaping(Result<[Category], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let categories = Category.getCategories(from: value)
                    completion(.success(categories))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Метод для загрузки изображений из сети
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Метод для загрузки данных из сети
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
