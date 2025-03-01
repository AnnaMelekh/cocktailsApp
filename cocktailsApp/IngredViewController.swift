//
//  IngredViewController.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 01.03.2025.
//


import UIKit

final class IngredViewController: UIViewController {
    
    var networkService = NetworkService()
    let ingredients = Ingredient.allCases

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        networkService.delegate = self
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout = createLayoutForCollection()
    }
}

// MARK: - UICollectionViewDelegate
extension IngredViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ingredient = ingredients[indexPath.item].rawValue
        
        networkService.performRequest(ingredient: ingredient) { [weak self] cocktails in
            DispatchQueue.main.async {
               
                self?.didUpdateData(cocktails: cocktails)
            }
        }
    }
}

extension IngredViewController: NetworkServiceDelegate {
    func didUpdateData(cocktails: [CocktailModel]) {
        guard let tabBar = self.tabBarController else {
                    print("TabBarController is nil")
                    return
                }
        
        guard let mainVC = tabBar.viewControllers?[1] as? MainViewController else {
            return
        }


            mainVC.cocktails = cocktails
            mainVC.tableView.reloadData()
    
            tabBar.selectedIndex = 1
        
    }
    
    func didFailWithError(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}
    

            

// MARK: - UICollectionViewDataSource
extension IngredViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.identifier,
            for: indexPath
        ) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        let ingredient = ingredients[indexPath.item]
        
        cell.configure(with: ingredient)
      
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension IngredViewController: UICollectionViewDelegateFlowLayout {}

// MARK: - Private Methods
private extension IngredViewController {
    func createLayoutForCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let basicSpacing: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let paddingWidth = basicSpacing * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        layout.minimumLineSpacing = basicSpacing
        layout.minimumInteritemSpacing = basicSpacing
        layout.sectionInset = UIEdgeInsets(top: basicSpacing, left: basicSpacing, bottom: 0, right: basicSpacing)
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
        return layout
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
        ])
    }
    
}
