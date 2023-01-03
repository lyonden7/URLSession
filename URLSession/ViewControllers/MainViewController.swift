//
//  MainViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 04.01.2023.
//

import UIKit

enum Link: String {
    case categoryURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    case ingredientsURL = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
}

class MainViewController: UIViewController {

    // MARK: - IB Actions
    @IBAction func fetchDataButtonTapped(_ sender: UIButton) {
        sender.tag == 0 ? fetchCategories() : fetchIngredients()
    }
    
    
    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug Area",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

// MARK: - Networking
extension MainViewController {
    private func fetchCategories() {
        guard let url = URL(string: Link.categoryURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let categories = try JSONDecoder().decode(Categories.self, from: data)
                self?.successAlert()
                print(categories)
            } catch let error {
                self?.failedAlert()
                print(error)
            }
            
        }.resume()
    }
    
    private func fetchIngredients() {
        guard let url = URL(string: Link.ingredientsURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let meals = try JSONDecoder().decode(Meals.self, from: data)
                self?.successAlert()
                print(meals)
            } catch let error {
                self?.failedAlert()
                print(error)
            }
        }.resume()
    }
}
