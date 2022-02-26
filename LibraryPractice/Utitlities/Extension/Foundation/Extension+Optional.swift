//
//  Optional.swift
//  Yatru
//
//  Created by Nutan Niraula on 8/5/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var hasValue: Bool {
        return self != nil
    }
}
