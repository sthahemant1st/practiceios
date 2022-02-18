//
//  NotebookListViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import UIKit

class NotebookListViewController: UIViewController {

    weak var coordinator: NoteCoordinator?
    @IBOutlet weak var tableView: UITableView!
    
    private var notebookList = [Notebook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NoteBook List"
        initTableView()
        
    }
    
    private func initTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "notebookCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func onCreateNotebookClick(_ sender: Any) {
        notebookList.append(Notebook(name: "NoteBook \(Data())"))
    }
}

extension NotebookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notebookCell", for: indexPath)
        cell.textLabel?.text = notebookList[indexPath.row].name
        cell.detailTextLabel?.text = "\(notebookList[indexPath.row].notes.count)"
        return cell
    }
    
    
}
