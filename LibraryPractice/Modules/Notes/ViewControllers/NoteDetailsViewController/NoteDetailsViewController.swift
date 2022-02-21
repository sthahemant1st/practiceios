//
//  NoteDetailsViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import UIKit

class NoteDetailsViewController: UIViewController, UITextViewDelegate {
    
    var dataConroller: DataController!
    var note: Note!
    var onDelete: (() -> Void)!
    
    weak var coordinator: NoteCoordinator?

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try? dataConroller.viewContext.saveChanges()
    }
    
    private func configureView() {
        title = String(describing: note.creationDate)
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(onTrashClick))
        navigationItem.rightBarButtonItem = button
        
        textView.text = note.text
        textView.delegate = self
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        note.text = textView.text
        return true
    }
    
    
    @objc func onTrashClick() {
        showAlert( withMessage: "Are you sure you want to delete?", okHandler: {
            self.coordinator?.dismissNoteDetails()
            self.onDelete()
        })
    }

}
