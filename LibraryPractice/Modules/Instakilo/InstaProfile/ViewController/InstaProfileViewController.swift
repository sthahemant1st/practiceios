//
//  InstaProfileViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 23/02/2022.
//

import UIKit

class InstaProfileViewController: UIViewController {
    weak var coordinator: ProfileCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func postClick(_ sender: Any) {
        coordinator.showPostListView()
    }
}
