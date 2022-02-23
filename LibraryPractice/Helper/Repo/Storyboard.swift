//
//  Storyboard.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    case note = "Note"
    case instakilo = "Instakilo"
    
    private var name: String {
        return self.rawValue
    }
    
    private func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.name, bundle: nil)
    }
    
    func viewController<T: UIViewController>(_: T.Type) -> T {
        // swiftlint:disable force_cast
        return storyboard().instantiateViewController(withIdentifier: T.identifier) as! T
        // swiftlint:enable force_cast
    }
    
}
