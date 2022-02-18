//
//  Note.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation

class Note {
    /// The date the note was created
    let creationDate: Date

    /// The note's text
    var text: String

    init(text: String = "New note") {
        self.text = text
        creationDate = Date()
    }
}
