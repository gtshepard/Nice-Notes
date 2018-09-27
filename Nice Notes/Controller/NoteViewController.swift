//
//  NoteViewController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var noteTitle: UINavigationItem!
    
    var dataController: DataController!
    var note: NoteMO!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.noteTextField.delegate = self
        //name of note
        let noteToRetrieve = noteTitle.title
        //our fetch is for Note model objects
        let fetchRequest: NSFetchRequest<NoteMO> = NoteMO.fetchRequest()
        //query a specific note by name
        fetchRequest.predicate = NSPredicate(format: "name==%@", noteToRetrieve!)
        //fecth the data for the note
        let result = try? dataController.viewContext.fetch(fetchRequest)
        
        //only one note to fetch
        note = result![0]
        //dsiplay text
        noteTextField.text = note.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func save(){
        note.text = noteTextField.text!
        try? dataController.viewContext.save()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        save()
    }

  
    //UI is blank when it comes up and looks like you can type.. What can you do about that? looks like loose leaf
    // cant name the note after
    // get check box, that would be a lengthy implementation
    //text manipulation. that would also be lengthy, bold, italic, bullets etc.
}
