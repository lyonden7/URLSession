//
//  MealImageViewCell.swift
//  URLSession
//
//  Created by Денис Васильев on 10.01.2023.
//

import UIKit

class MealImageViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet var mealImageView: UIImageView! {
        didSet {
            mealImageView.layer.cornerRadius = 15
        }
    }
    
    // MARK: - Configure cell
    func configure(with meal: MealDetail) {
        NetworkManager.shared.fetchImage(from: meal.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.mealImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
