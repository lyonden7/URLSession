//
//  CategoryViewCell.swift
//  URLSession
//
//  Created by Денис Васильев on 18.01.2023.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var categoryIDLabel: UILabel!
    @IBOutlet var categoryImageView: UIImageView! {
        didSet {
            categoryImageView.layer.cornerRadius = 15
        }
    }
    
    // MARK: - Configure cell
    func configure(with category: Category) {
        categoryNameLabel.text = category.name
        categoryIDLabel.text = "ID: \(category.id)"
        
        NetworkManager.shared.fetchData(from: category.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.categoryImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Override Methods
    override func prepareForReuse() {
        categoryImageView.image = nil
    }
}
