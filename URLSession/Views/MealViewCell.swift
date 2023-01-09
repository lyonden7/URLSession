//
//  MealViewCell.swift
//  URLSession
//
//  Created by Денис Васильев on 08.01.2023.
//

import UIKit

class MealViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet var mealImageView: UIImageView!
    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var mealIDLabel: UILabel!
    
    // MARK: - Configure cell
    func configure(wiht meal: Meal) {
        mealNameLabel.text = meal.name
        mealIDLabel.text = "ID: \(meal.id)"
        
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
