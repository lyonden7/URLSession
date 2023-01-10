//
//  MealCategoryViewCell.swift
//  URLSession
//
//  Created by Денис Васильев on 10.01.2023.
//

import UIKit

class MealCategoryViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    
    // MARK: - Configure Cell
    func configure(with meal: MealDetail) {
        categoryLabel.text = meal.category
        areaLabel.text = meal.area
    }
}
