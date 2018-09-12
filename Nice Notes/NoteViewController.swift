//
//  NoteViewController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

 
    @IBOutlet weak var notebookButton: UIBarButtonItem!
    @IBOutlet weak var noteNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var noteTextField: UITextView!
    
    var noteName:String!
    var noteText:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func backToNotebook(_ sender: Any) {
        
      // _ = self.navigationController?.popViewController(animated: true)
     
        
        
    }
    
    
    @IBAction func saveNote(_ sender: Any) {
        
        //pass data back to previous vc
        //then use save method
        
    }
    
    
    
}
