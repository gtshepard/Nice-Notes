//
//  NoteViewController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var noteTitle: UINavigationItem!
    
    var noteName:String!
    var noteText:String!
    var dataController: DataController!
    var note: NoteMO!
    
  //var noteTexFieldDelegate: UITextFieldDelegate =  NoteTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        print("ViewDidLoad")
        
        let noteToRetrieve = noteTitle.title
        let fetchRequest: NSFetchRequest<NoteMO> = NoteMO.fetchRequest()
        //like WHERE in SQL, search entity where name == notetile
        fetchRequest.predicate = NSPredicate(format: "name==%@", noteToRetrieve!)
        let result = try? dataController.viewContext.fetch(fetchRequest)
        note = result![0]
        noteTextField.text = note.text
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // noteTextField.text? = noteText
    
    }
    
    func save(){
        note.text = noteTextField.text!
        try? dataController.viewContext.save()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       
        save()
    }
    
    
    
}
