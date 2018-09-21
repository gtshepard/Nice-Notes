//
//  Note+CoreDataClass.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/15/18.
//  Copyright © 2018 Garrison. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note) public class Note: NSManagedObject {
    //note to make sure this class works after you create the classs you need to prefix the actual class name with your project file name. i.e ig you class is Note, and the project is Nice Notes, the file name should be
    //Nice_Notes.Note (leave what ever is trailing after note).
    //then go to the data model. click the entity that you made class for, and be sure to go to the inspector tab and select the thrid tab. change the the class definition optin to manual.
    //then go to the prefences tab under xcode, got locations, then follow the path to derived data. then delete the folder with your project name. next reviesit you rpject. and press command shift k to clean the project. after this, build your project and it will be error Free :)

}
