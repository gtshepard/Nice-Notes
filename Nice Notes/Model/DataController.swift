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
    //sets up core data stack
    
    
    let persistentContainer: NSPersistentContainer
    
    init(modelName: String){
        //has useful methods to reduce boilerplate code
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    var viewContext: NSManagedObjectContext {
        //important to keep data persitent and consistent across controllers
        return persistentContainer.viewContext
    }
    
    func load(completion: (()-> Void)? = nil){
        //loads persistent store. if store does not exist the trialing closure is executed
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
        // can add in completion handler if so choose
        //allows for immediate eexuction after laod compeletes
        completion?()
    }
}
