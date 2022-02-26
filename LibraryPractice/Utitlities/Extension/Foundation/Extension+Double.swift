//
//  Double.swift
//  Yatru
//
//  Created by Insight Workshop on 10/4/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Double {
    
    var unWrapped: Double {
        return self ?? 0.0
    }
    
}

extension Double {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toKm: Double {
        let meters = Measurement(value: self, unit: UnitLength.meters)
        return meters.converted(to: .kilometers).value
    }
    
    var toRoundedOffString: String {
        return String(format: "%.2f", self)
    }
    
    var toString: String {
        return String(self)
    }
    
}
