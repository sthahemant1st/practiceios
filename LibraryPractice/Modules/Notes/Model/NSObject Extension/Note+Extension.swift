//
//  Note+Extension.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 20/02/2022.
//

import Foundation

extension Note {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate = Date()
    }
}
