//
//  Tabbar.swift
//
//  Created by Anna Melekhina on 28.02.2025.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    private let customTabBarView = UIView(frame: .zero)
    let mainVC = MainViewController()
    let bookmarksVC = BookmarksViewController()
    let createVC = IngredViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupCustomTabBarView()
        selectedIndex = 1
    }
    
    private func setupTabBar() {
        mainVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home"), selectedImage: UIImage(named: "home")?.withCircularBackground(color: UIColor(named: "pink1")!)?.withRenderingMode(.alwaysOriginal))
        bookmarksVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "bookmark"), selectedImage: UIImage(named: "bookmark")?.withCircularBackground(color: UIColor(named: "pink1")!)?.withRenderingMode(.alwaysOriginal))
        createVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "note"), selectedImage: UIImage(named: "note")?.withCircularBackground(color: UIColor(named: "pink1")!)?.withRenderingMode(.alwaysOriginal))
        
        self.viewControllers = [bookmarksVC, mainVC, createVC]
        
        
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.backgroundColor = .white
    }
    
    private func setupCustomTabBarView() {
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.shadowOpacity = 0.1
        customTabBarView.layer.shadowOffset = CGSize(width: 0, height: -2)
        customTabBarView.layer.shadowRadius = 10
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
        
        NSLayoutConstraint.activate([
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBarView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}

extension UIImage {
    func withCircularBackground(color: UIColor, padding: CGFloat = 10) -> UIImage? {
        let diameter = max(size.width, size.height) + 2 * padding
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter))
        let imageWithCircle = renderer.image { context in
            let circleRect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
            color.setFill()
            context.cgContext.fillEllipse(in: circleRect)
            
            let imageRect = CGRect(
                x: (diameter - size.width) / 2,
                y: (diameter - size.height) / 2,
                width: size.width,
                height: size.height)
            self.draw(in: imageRect)
        }
        return imageWithCircle
    }
}
