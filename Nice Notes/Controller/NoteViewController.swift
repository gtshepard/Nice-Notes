//
//  NoteViewController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var noteTitle: UINavigationItem!
    
    var dataController: DataController!
    var note: NoteMO!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.noteTextField.delegate = self
        
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
    }
    
    func save(){
        note.text = noteTextField.text!
        try? dataController.viewContext.save()
    }
    
    //TODO: implement delete
    func delete(){ }
    
    func textViewDidChange(_ textView: UITextView) {
        save()
    }
   
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}
  
    //UI is blank when it comes up and looks like you can type.. What can you do about that? looks like loose leaf
    // cant name the note after
    // get check box, that would be a lengthy implementation
    //text manipulation. that would also be lengthy, bold, italic, bullets etc.
}
