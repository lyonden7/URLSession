//
//  CategoryViewCell.swift
//  URLSession
//
//  Created by Денис Васильев on 05.01.2023.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var categoryIDLabel: UILabel!
    
    // MARK: - Configure cell
    func configure(with category: Category) {
        categoryNameLabel.text = category.name
        categoryIDLabel.text = "ID: \(category.id)"
        
        NetworkManager.shared.fetchImage(from: category.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.categoryImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
