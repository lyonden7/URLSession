//
//  CategoriesViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 05.01.2023.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var categories: [Category] = []

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        fetchCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "categoryCell",
            for: indexPath
        ) as? CategoryViewCell
        else {
            return UITableViewCell()
        }

        let category = categories[indexPath.row]
        cell.configure(with: category)

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let categoryDetailVC = segue.destination as? CategoryDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        categoryDetailVC.category = categories[indexPath.row]
    }
}

// MARK: - Table View Delegate
extension CategoriesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Networking
extension CategoriesViewController {
    private func fetchCategories() {
        NetworkManager.shared.fetch(Categories.self, from: Link.categoriesURL.rawValue) { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories.categories
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


