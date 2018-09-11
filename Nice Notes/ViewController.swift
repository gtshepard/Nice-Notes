//
//  ViewController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    @IBOutlet weak var notesTableView: UITableView!
    
    //collection of notes
    var notes: [NSManagedObject] = []
    var imagesForNoteCells: [UIImage] = [#imageLiteral(resourceName: "bunny"),#imageLiteral(resourceName: "character"),#imageLiteral(resourceName: "parrot"),#imageLiteral(resourceName: "snail"),#imageLiteral(resourceName: "squirrel"), #imageLiteral(resourceName: "wind")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
    }
    
    @IBAction func addNote(_ sender: Any) {
        createNote()
    }

    func selectImageForCell() -> UIImage{
        let index = Int(arc4random_uniform(UInt32(imagesForNoteCells.count)))
        return imagesForNoteCells[index]
    }
    func createNote(){
        
        let alert = UIAlertController(title: "Name Your Note", message: "Name Your Voice Note", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            print("NAME: \(nameToSave)")
          //  self.fileName = nameToSave
           // self.configureUI(button: self.recordButton, value: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCell")!
        
        return noteCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

