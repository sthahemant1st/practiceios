//
//  NSAttributedString.swift
//  Yatru
//
//  Created by Sagun Raj Lage on 7/24/19.
//  Copyright © 2019 Sagun Raj Lage. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    static func makeLocationHyperlink(for paths: [String],
                                      in string: String,
                                      _ texts: [String]) -> NSAttributedString {
        let nsString = NSString(string: string)
        let attributedString = NSMutableAttributedString(string: string)
        for (index, text) in texts.enumerated() {
            let range = nsString.range(of: text)
            let urlComponents = URLComponents(url: URL(string: paths[index])!, resolvingAgainstBaseURL: false)!
            attributedString.addAttribute(.link, value: urlComponents.url!, range: range)
            attributedString.addAttribute(.underlineStyle, value: 1, range: range)
            attributedString.addAttribute(.underlineColor, value: #colorLiteral(red: 0.9921568627, green: 0.8274509804, blue: 0, alpha: 1), range: range)
        }
        return attributedString
    }
    
    static func makeEmailAndHashtagHyperlink(for path: String,
                                             in string: String,
                                             _ emailAddressOrHashtag: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let attributedString = NSMutableAttributedString(string: string)
        let range = nsString.range(of: emailAddressOrHashtag)
        attributedString.addAttribute(.link, value: path, range: range)
        return attributedString
    }
    
}
