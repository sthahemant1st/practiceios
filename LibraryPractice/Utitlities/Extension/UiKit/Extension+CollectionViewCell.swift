//
//  CollectionViewCellExtension.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
