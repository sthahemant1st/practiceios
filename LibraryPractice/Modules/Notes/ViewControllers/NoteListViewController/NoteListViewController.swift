//
//  NoteListViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import UIKit
import CoreData

class NoteListViewController: UIViewController {

    weak var coordinator: NoteCoordinator?
    weak var dataController: DataController!
    var notebook: Notebook!
    private var fetchedRequestController: NSFetchedResultsController<Note>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBarButton()
        initTableView()
    }
    
    private func configureView() {
        title = notebook.name
        configureFetchedRequestControlelr()
        
    }
    
    fileprivate func configureFetchedRequestControlelr() {
        let predicate = NSPredicate(format: "notebook == %@", self.notebook)
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        fetchedRequestController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: dataController.viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: AppConstants.CoreData.noteCache)
        
        fetchedRequestController.delegate = self
        try? fetchedRequestController.performFetch()
    }
    
    private func configureNavigationBarButton() {
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing( editing, animated: true)
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteListCell")
    }

    @IBAction func onAddNoteClick(_ sender: Any) {
        let note = Note(context: dataController.viewContext)
        note.notebook = notebook
        try? dataController.viewContext.save()
    }
    
    private func deleteNote(at indexPath: IndexPath) {
        let note = fetchedRequestController.object(at: indexPath)
        dataController.viewContext.delete(note)
        try? dataController.viewContext.save()
    }
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = fetchedRequestController.object(at: indexPath)
        coordinator?.showNoteDetailsVC(note: note, onDelete: {
            self.deleteNote(at: indexPath)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRequestController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = fetchedRequestController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteListCell", for: indexPath)
        cell.textLabel?.text = "\(item.text!) (\(item.creationDate!.formatted(date: .complete, time: .omitted)))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteNote(at: indexPath)
        default:
            break
        }
    }
}

extension NoteListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
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
