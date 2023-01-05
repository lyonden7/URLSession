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
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        let category = categories[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = category.strCategory
        
        cell.contentConfiguration = content

        return cell
    }

}



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


