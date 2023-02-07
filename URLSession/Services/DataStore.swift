//
//  DataStore.swift
//  URLSession
//
//  Created by Денис Васильев on 01.02.2023.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    private init() {}
    
    func getIngridients(from meal: MealDetail, completion: ([String]) -> Void) {
        let ingridients = [
            meal.ingredient1,
            meal.ingredient2,
            meal.ingredient3,
            meal.ingredient4,
            meal.ingredient5,
            meal.ingredient6,
            meal.ingredient7,
            meal.ingredient8,
            meal.ingredient9,
            meal.ingredient10,
            meal.ingredient11,
            meal.ingredient12,
            meal.ingredient13,
            meal.ingredient14,
            meal.ingredient15
        ]
        
        let mealIngredients = ingridients.compactMap { $0 }
            .filter { !$0.isEmpty }
        
        completion(mealIngredients)
    }
    
    func getMeasures(from meal: MealDetail, completion: ([String]) -> Void) {
        let measures = [
            meal.measure1,
            meal.measure2,
            meal.measure3,
            meal.measure4,
            meal.measure5,
            meal.measure6,
            meal.measure7,
            meal.measure8,
            meal.measure9,
            meal.measure10,
            meal.measure11,
            meal.measure12,
            meal.measure13,
            meal.measure14,
            meal.measure15
        ]
        
        let mealMeasures = measures.compactMap { $0 }
        
        completion(mealMeasures)
    }
}
