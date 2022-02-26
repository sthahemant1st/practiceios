//
//  InstakiloMainViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 22/02/2022.
//

import UIKit

class InstaMainTabController: UITabBarController, UITabBarControllerDelegate {
    weak var coordinator: InstaCoordinator!
    var homeCoordinator: HomeCoordinator!
    var searchCoordinator: SearchCoordinator!
    var addPostCoordinator: AddPostCoordinator!
    var shopCoordinator: ShopCoordinator!
    var profileCoordintor: ProfileCoordinator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        self.delegate = self
    }
    
    private func configure() {
        homeCoordinator.start()
        searchCoordinator.start()
        addPostCoordinator.start()
        shopCoordinator.start()
        profileCoordintor.start()
        
        viewControllers = [
            homeCoordinator.navigationController,
            searchCoordinator.navigationController,
            addPostCoordinator.navigationController,
            shopCoordinator.navigationController,
            profileCoordintor.navigationController
        ]
        
        let tabImages = [
            "house.fill",
            "magnifyingglass",
            "plus.app",
            "bag",
            "person.crop.circle"
        ]
        
        if let tabs = tabBar.items {
            for (index, tab) in tabs.enumerated() {
                tab.image = UIImage(systemName: tabImages[index])
                tab.tag = index
            }
        }
        
        tabBar.barTintColor = UIColor.systemGray3
        tabBar.tintColor = UIColor.black
        tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        tabBar.layer.borderWidth = 1
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == addPostCoordinator.navigationController {
            coordinator.presentInstaAddPostView()
            return false
        }

        return true
    }
    
}
