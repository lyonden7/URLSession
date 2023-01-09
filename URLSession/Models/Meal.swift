//
//  Meal.swift
//  URLSession
//
//  Created by Денис Васильев on 08.01.2023.
//

struct Meal: Decodable {
    let id: String
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURL = "strMealThumb"
    }
}

struct Meals: Decodable {
    let meals: [Meal]
}
