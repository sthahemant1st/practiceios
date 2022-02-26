//
//  BiometricSuccessViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 21/02/2022.
//

import UIKit
import KeychainSwift

class BiometricSuccessViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    let keyChain = KeychainSwift(keyPrefix: AppConstants.KeyChain.prefix)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = keyChain.get(AppConstants.KeyChain.username)
        passwordLabel.text = keyChain.get(AppConstants.KeyChain.password)
    }

}
