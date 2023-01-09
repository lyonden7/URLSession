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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
