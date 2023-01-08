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
}

// MARK: - Setup View
extension CategoryDetailViewController {
    private func setupView() {
        title = category.categoryName
        categoryDescriptionTextView.text = category.categoryDescription
        
        NetworkManager.shared.fetchImage(from: category.categoryImageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.categoryImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}