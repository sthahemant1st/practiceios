//
//  ProfileCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 23/02/2022.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        navigationController = nc
        childCoordinators = []
    }
    
    func start() {
        let vc = ViewRepo.Instakilo.getInstaProfileViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showPostListView() {
        let vc = ViewRepo.Instakilo.getInstaPostListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
