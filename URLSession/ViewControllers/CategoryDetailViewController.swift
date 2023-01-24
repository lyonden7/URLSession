//
//  CategoryDetailViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 08.01.2023.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryDescriptionTextView: UITextView!
    @IBOutlet var seeMealsButton: UIButton! {
        didSet {
            seeMealsButton.layer.cornerRadius = 10
        }
    }
    
    // MARK: - Public Properties
    var category: Category!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mealVC = segue.destination as? MealsViewController else { return }
        mealVC.category = category
    }
}

// MARK: - Setup View
extension CategoryDetailViewController {
    private func setupView() {
        title = category.name
        categoryDescriptionTextView.text = category.description
        
        NetworkManager.shared.fetchData(from: category.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.categoryImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
