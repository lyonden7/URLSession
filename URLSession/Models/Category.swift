//
//  Category.swift
//  URLSession
//
//  Created by Денис Васильев on 04.01.2023.
//

struct Category: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
//    let strCategoryDescription: String
}

struct Categories: Decodable {
    let categories: [Category]
}

struct Ingredient: Decodable {
    let idIngredient: String
    let strIngredient: String
//    let strDescription: String
}

struct Meals: Decodable {
    let meals: [Ingredient]
}
