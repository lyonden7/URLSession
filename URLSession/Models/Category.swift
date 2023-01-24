//
//  Category.swift
//  URLSession
//
//  Created by Денис Васильев on 04.01.2023.
//

struct Category: Decodable {
    let id: String
    let name: String
    let imageURL: String
    let description: String
    
    init(categoryData: [String: Any]) {
        id = categoryData["idCategory"] as? String ?? ""
        name = categoryData["strCategory"] as? String ?? ""
        imageURL = categoryData["strCategoryThumb"] as? String ?? ""
        description = categoryData["strCategoryDescription"] as? String ?? ""
    }
    
    static func getCategories(from value: Any) -> [Category] {
        guard let value = value as? [String: [Any]] else { return [] }
        guard let categoriesData = value.values.first as? [[String: Any]] else { return [] }
        return categoriesData.compactMap { Category(categoryData: $0) }
    }
}
