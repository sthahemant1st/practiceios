//
//  InstaAddPostViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 23/02/2022.
//

import UIKit

class InstaAddPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
