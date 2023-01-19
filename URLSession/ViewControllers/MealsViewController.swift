//
//  MealsViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 09.01.2023.
//

import UIKit

class MealsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Public Properties
    var category: Category!
    
    // MARK: - Private Properties
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private var meals: [Meal] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(category.name) meals"
        fetchMeals()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mealDetailVC = segue.destination as? MealDetailViewController else { return }
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        mealDetailVC.meal = meals[indexPath.row]
    }
}

// MARK: - UICollectionViewDataSource
extension MealsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "mealCell",
            for: indexPath
        ) as? MealViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.borderWidth = 1
        
        let meal = meals[indexPath.row]
        cell.configure(with: meal)
    
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MealsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 1.3
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}

// MARK: - Networking
extension MealsViewController {
    private func fetchMeals() {
        let url = Link.mealsURL.rawValue + category.name
        NetworkManager.shared.fetch(Meals.self, from: url) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.meals = meals.meals
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
