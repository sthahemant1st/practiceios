//
//  DataController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 18/02/2022.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard  error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()

        }
    }
}

extension NSManagedObjectContext {
    func saveChanges() throws {
        if self.hasChanges {
            try self.save()
        }
    }
}
