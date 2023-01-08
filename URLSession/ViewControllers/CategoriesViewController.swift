//
//  CategoriesViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 05.01.2023.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "categoryCell",
            for: indexPath)
                as? CategoryViewCell
        else {
            return UITableViewCell()
        }

        let category = categories[indexPath.row]
        cell.configure(with: category)

        return cell
    }

}

// MARK: - Table View Delegate
extension CategoriesViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}


// MARK: - Networking
extension CategoriesViewController {
    private func fetchCategories() {
        guard let url = URL(string: Link.categoryURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let categories = try JSONDecoder().decode(Categories.self, from: data)
                self?.categories = categories.categories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                print(categories)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }

}


