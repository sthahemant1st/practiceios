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
}
