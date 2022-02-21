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
    var dataController: DataController!
    var navigationController: UINavigationController
    
    required init(navigationController nc: UINavigationController) {
        self.navigationController = nc
    }
    
    func start() {
        let notebookListVC = ViewRepo.Note.getNotebookListViewController()
        notebookListVC.coordinator = self
        notebookListVC.dataController = dataController
        navigationController.pushViewController(notebookListVC, animated: true)
    }
    
    func showNoteListVC(notebook: Notebook) {
        let noteListVC = ViewRepo.Note.getNoteListViewController()
        noteListVC.coordinator = self
        noteListVC.dataController = dataController
        noteListVC.notebook = notebook
        navigationController.pushViewController(noteListVC, animated: true)
    }
    
    func showNoteDetailsVC(note: Note, onDelete: (() -> Void)!) {
        let noteDetailsVC = ViewRepo.Note.getNoteDetailsViewController()
        noteDetailsVC.coordinator = self
        noteDetailsVC.note = note
        noteDetailsVC.dataConroller = dataController
        noteDetailsVC.onDelete = onDelete
        navigationController.pushViewController(noteDetailsVC, animated: true)
    }
    
    func dismissNoteDetails() {
        navigationController.popViewController(animated: true)
    }
    
}
