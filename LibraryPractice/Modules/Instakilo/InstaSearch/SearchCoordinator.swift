//
//  SearchCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 23/02/2022.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        navigationController = nc
        childCoordinators = []
    }
    
    func start() {
        let vc = ViewRepo.Instakilo.getInstaSearchViewController()
        navigationController.pushViewController(vc, animated: false)
    }
    
}
