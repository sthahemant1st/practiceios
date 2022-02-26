//
//  Int.swift
//  Yatru
//
//  Created by Insight Workshop on 10/1/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

extension Int {
    
    var stringValue: String {
        return "\(self)"
    }
    
}

extension Optional where Wrapped == Int {
    var unWrapped: Int {
        return self ?? -1
    }
}
