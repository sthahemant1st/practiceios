//
//  Utilities.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 22/02/2022.
//

import UIKit
import LocalAuthentication

struct Utilities {
    
    static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    static func isPhone5sOrless() -> Bool {
        return (UIScreen.main.nativeBounds.height == 960.0) || (UIScreen.main.nativeBounds.height == 1136.0)
    }
    
    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }
    
    static func biometricType() -> LABiometryType {
        let authContext = LAContext()
        var error: NSError?
        
        guard authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        if #available(iOS 11.0, *) {
            return authContext.biometryType
        }
        
        return  authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
    }
    
    static func isBiometricAvailable() -> Bool {
        return biometricType() != .none ? true : false
    }
    
}
