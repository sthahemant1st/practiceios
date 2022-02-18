//
//  MainCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        self.navigationController = nc
    }
    
    func start() {
        let mainVc = ViewRepo.Main.getMainViewController()
        mainVc.coordinator = self
        navigationController.pushViewController(mainVc, animated: true)
    }
    
    func showEmptyTableView() {
        let emptyTableVC = ViewRepo.Main.getEmptyTableViewConroller()
        emptyTableVC.coordinator = self
        navigationController.pushViewController(emptyTableVC, animated: true)
    }
    
    func showLottieView() {
        let lottieVC = ViewRepo.Main.getLottieViewController()
        lottieVC.coordinator = self
        navigationController.pushViewController(lottieVC, animated: true)
    }
    
    func showHeroView() {
        let heroOneVC = ViewRepo.Main.getHeroOneViewController()
        heroOneVC.coordinator = self
        navigationController.pushViewController(heroOneVC, animated: true)
    }
    
    func showHeroTwoVC() {
        let heroTwoVC = ViewRepo.Main.getHeroTwotViewController()
        heroTwoVC.coordinator = self
        navigationController.showHeroVC(heroTwoVC)
    }
    
    func showHeroListVC() {
        let heroListVC = ViewRepo.Main.getHeroListViewController()
        heroListVC.coordinator = self
        navigationController.showHeroVC(heroListVC)
    }
    
    func showNoteVc() {
        navigationController.delegate = self
        let noteCoordinator = NoteCoordinator(navigationController: navigationController)
        childCoordinators.append(noteCoordinator)
        noteCoordinator.start()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController
                .transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let buyViewController = fromViewController as? NotebookListViewController {
            childDidFinish(buyViewController.coordinator)
        }
         
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                print("child coordinator removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
