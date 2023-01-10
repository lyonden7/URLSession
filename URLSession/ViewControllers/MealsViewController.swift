//
//  MealsViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 09.01.2023.
//

import UIKit

class MealsViewController: UITableViewController {

    // MARK: - Public Properties
    var category: Category!
    
    // MARK: - Private Properties
    private var meals: [Meal] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(category.name) meals"
        fetchMeals()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "mealCell",
            for: indexPath
        ) as? MealViewCell
        else {
            return UITableViewCell()
        }

        let meal = meals[indexPath.row]
        cell.configure(wiht: meal)

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mealDetailVC = segue.destination as? MealDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        mealDetailVC.meal = meals[indexPath.row]
    }
}

// MARK: - Table View Delegate
extension MealsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Networking
extension MealsViewController {
    private func fetchMeals() {
        let url = Link.mealsURL.rawValue + category.name
        NetworkManager.shared.fetch(Meals.self, from: url) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.meals = meals.meals
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
