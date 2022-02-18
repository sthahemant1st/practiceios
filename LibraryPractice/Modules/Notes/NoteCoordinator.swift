//
//  NoteCoordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation
import UIKit

class NoteCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        self.navigationController = nc
    }
    
    func start() {
        let notebookListVC = ViewRepo.Note.getNotebookListViewController()
        notebookListVC.coordinator = self
        navigationController.pushViewController(notebookListVC, animated: true)
    }
    
    func showNoteListVC() {
        let noteListVC = ViewRepo.Note.getNoteListViewController()
        noteListVC.coordinator = self
        navigationController.pushViewController(noteListVC, animated: true)
    }
    
    func showNoteDetailsVC() {
        let noteDetailsVC = ViewRepo.Note.getNoteDetailsViewController()
        noteDetailsVC.coordinator = self
        navigationController.pushViewController(noteDetailsVC, animated: true)
    }
    
}
