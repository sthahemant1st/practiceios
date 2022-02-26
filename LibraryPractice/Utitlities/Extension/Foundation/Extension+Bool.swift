//
//  Bool.swift
//  Yatru
//
//  Created by Nutan Niraula on 8/5/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

extension Bool {
    
    var isFalse: Bool {
        return self == false
    }
    
}

extension Optional where Wrapped == Bool {
    
    var unWrapped: Bool {
        return self ?? false
    }
    
}
