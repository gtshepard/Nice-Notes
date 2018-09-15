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
  //var noteTexFieldDelegate: UITextFieldDelegate =  NoteTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteTextField.text? = noteText
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? ViewController {
            controller.noteNameToSave = noteName
            controller.noteTextToSave = noteTextField.text!
            
        }
    }
}
