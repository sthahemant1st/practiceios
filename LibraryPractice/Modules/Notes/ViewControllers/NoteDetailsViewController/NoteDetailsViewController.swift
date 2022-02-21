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
        
        textView.attributedText = note.attributedText
        textView.delegate = self
        
        // keyboard toolbar configuration
        configureToolbarItems()
        configureTextViewInputAccessoryView()
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        note.attributedText = textView.attributedText
        return true
    }
    
    
    @objc func onTrashClick() {
        showAlert( withMessage: "Are you sure you want to delete?", okHandler: {
            self.coordinator?.dismissNoteDetails()
            self.onDelete()
        })
    }

    @IBAction func deleteTapped(sender: Any) {
        showDeleteAlert()
    }
    
    @IBAction func boldTapped(sender: Any) {
        showDeleteAlert()
    }
    
    @IBAction func redTapped(sender: Any) {
        showDeleteAlert()
    }
    
    @IBAction func cowTapped(sender: Any) {
        showDeleteAlert()
    }
}

// MARK: - Toolbar

extension NoteDetailsViewController {
    /// Returns an array of toolbar items. Used to configure the view controller's
    /// `toolbarItems' property, and to configure an accessory view for the
    /// text view's keyboard that also displays these items.
    func makeToolbarItems() -> [UIBarButtonItem] {
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped(sender:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let bold = UIBarButtonItem(image: #imageLiteral(resourceName: "toolbar-bold")
//                                   style: .plain,
//                                   target: self,
//                                   action: #selector(boldTapped(sender:)))
//        let red = UIBarButtonItem(image: #imageLiteral(resourceName: "toolbar-underline")
//                                   style: .plain,
//                                   target: self,
//                                   action: #selector(redTapped(sender:)))
//        let cow = UIBarButtonItem(image: #imageLiteral(resourceName: "texture-cow")
//                                   style: .plain,
//                                   target: self,
//                                   action: #selector(cowTapped(sender:)))

//        return [trash, space, bold, space, red, space, cow]
        return [trash, space]
    }

    /// Configure the current toolbar
    func configureToolbarItems() {
        toolbarItems = makeToolbarItems()
        navigationController?.setToolbarHidden(false, animated: false)
        }

    /// Configure the text view's input accessory view -- this is the view that
    /// appears above the keyboard. We'll return a toolbar populated with our
    /// view controller's toolbar items, so that the toolbar functionality isn't
    /// hidden when the keyboard appears
    func configureTextViewInputAccessoryView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        toolbar.items = makeToolbarItems()
        textView.inputAccessoryView = toolbar
    }

    // MARK: Helper methods for actions
    private func showDeleteAlert() {
        let alert = UIAlertController(title: "Delete Note?", message: "Are you sure you want to delete the current note?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.coordinator?.dismissNoteDetails()
            strongSelf.onDelete?()
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
}
