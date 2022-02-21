//
//  NotebookListViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import UIKit
import CoreData

class NotebookListViewController: UIViewController {

    weak var coordinator: NoteCoordinator?
    @IBOutlet weak var tableView: UITableView!
    
    private var frc: NSFetchedResultsController<Notebook>!
    
    var dataController: DataController!
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        initTableView()
        
    }
    
    private func configureView() {
        title = "Notebooks"
        navigationItem.rightBarButtonItem = editButtonItem
        
        configureFetchRequestController()
    }
    
    fileprivate func configureFetchRequestController() {
        let fetchRequest: NSFetchRequest<Notebook> = Notebook.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                         managedObjectContext: dataController.viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: AppConstants.CoreData.notebookCache)
        frc.delegate = self
        
        try? frc.performFetch()
    }
    
    private func initTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "notebookCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing( editing, animated: true)
    }

    @IBAction func onCreateNotebookClick(_ sender: Any) {
            presentNewNotebookAlert()
    }
    
    func presentNewNotebookAlert() {
        let alert = UIAlertController(title: "New Notebook",
                                      message: "Enter a name for this notebook",
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            if let name = alert.textFields?.first?.text {
                self?.addNotebook(name: name)
            }
        }
        saveAction.isEnabled = false

        alert.addTextField { textField in
            textField.placeholder = "Name"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                if let text = textField.text, !text.isEmpty {
                    saveAction.isEnabled = true
                } else {
                    saveAction.isEnabled = false
                }
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    func addNotebook(name: String) {
        print(name)
        let notebook = Notebook(context: dataController.viewContext)
        notebook.name = name
        try? dataController.viewContext.save()
    }
    
    func deleteNotebook(at indexPath: IndexPath) {
        dataController.viewContext.delete(frc.object(at: indexPath))
        try? dataController.viewContext.save()
    }
}

extension NotebookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showNoteListVC( notebook: frc.object(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notebookCell", for: indexPath)
        let item = frc.object(at: indexPath)
        cell.textLabel?.text = "\(item.name!) (\(item.notes!.count))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("delete editStyle")
            deleteNotebook(at: indexPath)
        case .insert:
            print("insert")
        default: ()
        }
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UISwipeActionsConfiguration(actions: [
//            UIContextualAction(style: .destructive, title: "Delete", handler: {
//                _,_,_ in
//                print("delete")
//            }),
//            UIContextualAction(style: .normal, title: "Update", handler: {
//                _,_,_ in
//                print("update")
//            })
//                                                          ])
//        return action
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UISwipeActionsConfiguration(actions: [
//            UIContextualAction(style: .destructive, title: "Delete", handler: {
//                _,_,_ in
//                print("delete trailing")
//            }),
//            UIContextualAction(style: .normal, title: "Update", handler: {
//                _,_,_ in
//                print("update trailing")
//            }),
//                                                          ])
//        return action
//    }
    
}

extension NotebookListViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .right)
            break
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            fatalError("notebook list didChange not handled")
        }
    }
}
