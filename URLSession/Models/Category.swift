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
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageURL = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct Categories: Decodable {
    let categories: [Category]
}
