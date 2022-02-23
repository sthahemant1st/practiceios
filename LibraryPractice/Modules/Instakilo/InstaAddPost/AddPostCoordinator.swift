//
//  AddPostCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 23/02/2022.
//

import UIKit

class AddPostCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var parentCoordinator: InstakiloCoordinator!
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        navigationController = nc
        childCoordinators = []
    }
    
    func start() {
    }
    
}
