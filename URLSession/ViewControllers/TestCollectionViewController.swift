//
//  TestCollectionViewController.swift
//  URLSession
//
//  Created by Денис Васильев on 17.01.2023.
//

import UIKit

class TestCollectionViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var categories: [Category] = []

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TestCell",
            for: indexPath
        ) as? TestViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 15
        
        let category = categories[indexPath.item]
        cell.configure(with: category)
    
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension TestCollectionViewController: UICollectionViewDelegateFlowLayout {
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
extension TestCollectionViewController {
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
