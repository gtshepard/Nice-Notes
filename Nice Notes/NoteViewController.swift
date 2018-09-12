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
    
    var noteName:String!
    var noteText:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteTextField.text? = noteText
    }
 
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? ViewController {
            controller.noteNameToSave = noteName // Here you pass the data back to your original view controller
            controller.noteTextToSave = noteTextField.text!
        }
        
    }
  
    
    
}
