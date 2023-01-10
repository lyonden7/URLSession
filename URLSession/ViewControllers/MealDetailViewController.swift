//
//  MealDetailViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 09.01.2023.
//

import UIKit

enum CellType: Int, CaseIterable {
    case imageCell
    case categoryCell
    case instructionsCell
    case ingredientCell
}

class MealDetailViewController: UITableViewController {
    
    // MARK: - Public Properties
    var meal: Meal!
    
    // MARK: - Private Properties
    private var mealDetails: [MealDetail] = []
    private var mealIngredients: [String] = []
    private var mealMeasures: [String] = []

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMealDetails()
        title = meal.name
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        CellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case CellType.instructionsCell.rawValue:
            return "Instructions"
        case CellType.ingredientCell.rawValue:
            return "Ingredients"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CellType.ingredientCell.rawValue:
            return mealIngredients.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let meal = mealDetails.first else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "imageCell",
                for: indexPath
            ) as? MealImageViewCell
            else {
                return UITableViewCell()
            }
            
            cell.configure(with: meal)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "categoryCell",
                for: indexPath
            ) as? MealCategoryViewCell
            else {
                return UITableViewCell()
            }
            
            cell.configure(with: meal)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "instructionsCell",
                for: indexPath
            )
            
            var content = cell.defaultContentConfiguration()
            content.text = meal.instructions
            cell.contentConfiguration = content
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ingredientCell",
                for: indexPath
            )
            
            var content = cell.defaultContentConfiguration()
            let ingredient = mealIngredients[indexPath.row]
            let measure = mealMeasures[indexPath.row]
            content.text = ingredient
            content.secondaryText = measure
            cell.contentConfiguration = content
            return cell
        }
    }
}

// MARK: - Table View Delegate
extension MealDetailViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Networking
extension MealDetailViewController {
    private func fetchMealDetails() {
        let url = Link.mealDetailURL.rawValue + meal.id
        NetworkManager.shared.fetch(MealsDetail.self, from: url) { [weak self] result in
            switch result {
            case .success(let mealsDetail):
                self?.mealDetails = mealsDetail.meals
                self?.getIngredients()
                self?.getMeasures()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Private methods
extension MealDetailViewController {
    private func getIngredients() {
        guard let meal = mealDetails.first else { return }
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
        
        ingridients.forEach {
            guard let item = $0 else { return }
            if item == "" {
                return
            }
            mealIngredients.append(item)
        }
    }
    
    private func getMeasures() {
        guard let meal = mealDetails.first else { return }
        
        mealMeasures = [
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
    }
}
