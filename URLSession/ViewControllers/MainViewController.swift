//
//  MainViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 04.01.2023.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug Area"
        }
    }
}

class MainViewController: UIViewController {

    // MARK: - IB Actions
    @IBAction func fetchDataButtonTapped(_ sender: UIButton) {
        sender.tag == 0 ? fetchCategories() : fetchIngredients()
    }
    
    
    // MARK: - Private Methods
    private func showAlert(_ alert: Alert) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: alert.title,
                message: alert.message,
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
                self?.showAlert(Alert.success)
                print(categories)
            } catch let error {
                self?.showAlert(Alert.failed)
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
                self?.showAlert(Alert.success)
                print(meals)
            } catch let error {
                self?.showAlert(Alert.failed)
                print(error)
            }
        }.resume()
    }
}
