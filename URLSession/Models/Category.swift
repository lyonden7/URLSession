//
//  Category.swift
//  URLSession
//
//  Created by Денис Васильев on 04.01.2023.
//

struct Category: Decodable {
    let categoryID: String
    let categoryName: String
    let categoryImageURL: String
//    let strCategoryDescription: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "idCategory"
        case categoryName = "strCategory"
        case categoryImageURL = "strCategoryThumb"
//        case categoryDescription = "strCategoryDescription"
    }
}

struct Categories: Decodable {
    let categories: [Category]
}

struct Ingredient: Decodable {
    let ingredientID: String
    let ingredientName: String
//    let strDescription: String
    
    enum CodingKeys: String, CodingKey {
        case ingredientID = "idIngredient"
        case ingredientName = "strIngredient"
//        case ingredientDescription = "strDescription"
    }
}

struct Meals: Decodable {
    let meals: [Ingredient]
}
