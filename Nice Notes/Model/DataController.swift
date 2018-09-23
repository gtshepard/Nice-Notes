//
//  DataController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/22/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import Foundation
import CoreData


class DataController {
    
    // this class sets up core data stack
    
    let persistentContainer: NSPersistentContainer
    
    init(modelName: String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func load(completion: (()-> Void)? = nil){
        
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
        completion?()
    }
}
