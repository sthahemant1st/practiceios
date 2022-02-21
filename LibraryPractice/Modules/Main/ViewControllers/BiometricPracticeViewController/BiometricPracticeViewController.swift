//
//  BiometricPracticeViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 21/02/2022.
//

import UIKit
import LocalAuthentication

class BiometricPracticeViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    @IBOutlet weak var useBiometricBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        useBiometricBtn.layer.cornerRadius = 8
        useBiometricBtn.layer.borderWidth = 1
        useBiometricBtn.layer.borderColor = UIColor.systemGray4.cgColor

    }
    
    @IBAction func onBiometricBtnClick(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if success {
                        //login
                        self.coordinator?.showBiometricSuccessView()
                    } else {
                        //error
//                        self.showAlertWithOk(withMessage: "Authentication Failed")
                    }
                }
            }
        } else {
            // no biometric
            print("no biometric")
        }
    }
}
