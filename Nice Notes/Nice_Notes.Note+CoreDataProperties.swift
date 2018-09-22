//
//  Note+CoreDataProperties.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/15/18.
//  Copyright © 2018 Garrison. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var text: String?

    
    
    
}
