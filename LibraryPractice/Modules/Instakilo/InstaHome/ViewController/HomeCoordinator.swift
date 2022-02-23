//
//  HomeCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 23/02/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        navigationController = nc
        childCoordinators = []
    }
    
    func start() {
        let vc = ViewRepo.Instakilo.getInstaHomeViewController()
        navigationController.pushViewController(vc, animated: false)
    }
    
}
