//
//  CategoriesViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 17.01.2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var categories: [Category] = []

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let categoryDetailVC = segue.destination as? CategoryDetailViewController else { return }
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        categoryDetailVC.category = categories[indexPath.item]
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "categoryCell",
            for: indexPath
        ) as? CategoryViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.borderWidth = 1
        
        let category = categories[indexPath.item]
        cell.configure(with: category)
    
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
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
extension CategoriesViewController {
    private func fetchCategories() {
        NetworkManager.shared.fetch(Categories.self, from: Link.categoriesURL.rawValue) { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories.categories
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
