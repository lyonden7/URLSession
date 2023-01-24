//
//  MealViewCell.swift
//  URLSession
//
//  Created by Денис Васильев on 08.01.2023.
//

import UIKit

class MealViewCell: UICollectionViewCell {

    // MARK: - IB Outlets
    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var mealIDLabel: UILabel!
    @IBOutlet var mealImageView: UIImageView! {
        didSet {
            mealImageView.layer.cornerRadius = 15
        }
    }
    
    // MARK: - Configure cell
    func configure(with meal: Meal) {
        mealNameLabel.text = meal.name
        mealIDLabel.text = "ID: \(meal.id)"
        
        NetworkManager.shared.fetchData(from: meal.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.mealImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Override Methods
    override func prepareForReuse() {
        mealImageView.image = nil
    }
}
