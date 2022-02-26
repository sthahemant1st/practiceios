//
//  String.swift
//  Yatru
//
//  Created by Sagun Raj Lage on 8/6/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var toDouble: Double {
        return Double(self).unWrapped
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var capitalizedFullName: String {
        let componenets = self.split(separator: " ")
        let capitalizedComponents = componenets.map { (subString) -> String in
            return String(subString).capitalizedFirstLetter
        }
        return capitalizedComponents.joined(separator: " ")
    }
    
    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }
    
    var isInValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return !(predicate.evaluate(with: self))
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*?[A-Za-z])(?=.*?[0123456789#?!@$%^&*-]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: self)
    }
    
    var isValidFullName: Bool {
        let alphaRegEx = "[A-Za-z ]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", alphaRegEx)
        return predicate.evaluate(with: self)
    }
    
    var isInValidPhoneNumber: Bool {
        let alphaRegEx = "[0-9]{10}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", alphaRegEx)
        return !(predicate.evaluate(with: self))
    }
    
    func getColoredSubString(with subStringToColor: String,
                             and color: UIColor) -> NSAttributedString {
        let range = (self as NSString).range(of: subStringToColor)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: color,
                                      range: range)
        return attributedString
    }
    
}

extension Optional where Wrapped == String {
    
    var unWrapped: String {
        return self ?? ""
    }
}
