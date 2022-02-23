//
//  InstakiloCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 22/02/2022.
//

import UIKit

class InstakiloCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        navigationController = nc
        childCoordinators = []
    }
    
    func start() {
        let vc = ViewRepo.Instakilo.getInstakiloMainController()
        vc.coordinator = self
        
        let addPostCoordinator = AddPostCoordinator(navigationController: UINavigationController())
        addPostCoordinator.parentCoordinator = self
        vc.profileCoordintor = ProfileCoordinator(navigationController: UINavigationController())
        vc.shopCoordinator = ShopCoordinator(navigationController: UINavigationController())
        vc.addPostCoordinator = addPostCoordinator
        vc.searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
        vc.homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        navigationController.setViewControllers([vc], animated: true)
        
    }
    
    func presentInstaAddPostView() {
        let vc = ViewRepo.Instakilo.getInstaAddPostViewController()
        
        navigationController.pushViewController(vc, animated: true)
        
//        vc.coordinator = self
        
//        let nc = UINavigationController(rootViewController: vc)
//        nc.modalPresentationStyle = .fullScreen
//        navigationController.present(nc, animated: true, completion: nil)
    }
}
