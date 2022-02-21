//
//  ViewControllerExtension.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    func showAlert(alertTitle: String = AppConstants.appName,
                   withMessage message: String,
                   okTitle: String = "Yes",
                   okHandler: @escaping () -> Void = {},
                   cancelTitle: String = "Cancel",
                   cancelHandler: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            okHandler()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { (_) in
            cancelHandler()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithOk(alertTitle: String = AppConstants.appName,
                         withMessage message: String,
                         okTitle: String = "OK",
                         okAction: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            okAction()
        }
        alertController.view.tintColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
