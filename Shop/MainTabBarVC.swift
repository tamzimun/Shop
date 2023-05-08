//
//  MainTabBarVC.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    private let titles: [String] = ["Main", "Favorite", "Profile"]
    private let images: [UIImage] = [
        UIImage(systemName: "house")!,
        UIImage(systemName: "heart")!,
        UIImage(systemName: "person.fill")!
    ]

    private var mainVC = UINavigationController(rootViewController: MainAssembly().assemle())
    private var favoriteVC = FavoriteViewController()
    private var profileVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeTabBarViews()
    }
    
    private func makeTabBarViews() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        setViewControllers([mainVC, favoriteVC, profileVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].title = titles[i]
            items[i].image = images[i]
        }
    }
    
}

