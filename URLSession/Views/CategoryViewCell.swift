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
        categoryNameLabel.text = category.categoryName
        categoryIDLabel.text = "ID: \(category.categoryID)"
        
        guard let url = URL(string: category.categoryImageURL) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self?.categoryImageView.image = UIImage(data: imageData)
            }
        }
    }
}
