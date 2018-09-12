//
//  ViewController.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {

    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    @IBOutlet weak var notesTableView: UITableView!
    
    //collection of notes
    var notebook: [NSManagedObject] = []
    var imagesForNoteCells: [UIImage] = [#imageLiteral(resourceName: "bunny"),#imageLiteral(resourceName: "character"),#imageLiteral(resourceName: "parrot"),#imageLiteral(resourceName: "snail"),#imageLiteral(resourceName: "squirrel"), #imageLiteral(resourceName: "wind")]
    var noteNameToSave: String!
    var noteTextToSave: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        notesTableView.delegate = self
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        //3
        do {
            notebook = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let noteText = noteTextToSave {
            print(noteText)
            
            //MARK: Bug, doesnt save the right text in the note sometimes
            //most likely do to the variable witht he thext that gets passed back and forth
            for note in notebook {
                
                if note.value(forKey: "name") as! String == noteNameToSave! {
                    note.setValue( noteText, forKey: "text")
                   return
                }
            }
            
            save(name: noteNameToSave!, text: noteTextToSave!)
            notesTableView.reloadData()
        }
   
    }
    @IBAction func addNote(_ sender: Any) {
     
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            self.save(name: nameToSave, text: "")
            self.notesTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func save(name: String, text: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
       note.setValue(name, forKeyPath: "name")
       note.setValue(text, forKeyPath: "text")
        
        // 4
        do {
            try managedContext.save()
            notebook.append(note)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote"{
            let noteViewController  = segue.destination as! NoteViewController
            let note = sender as! [String]
            noteViewController.noteName = note[0]
            noteViewController.noteText = note[1]
        }
    }
    
    func selectImageForCell() -> UIImage{
        let index = Int(arc4random_uniform(UInt32(imagesForNoteCells.count)))
        return imagesForNoteCells[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notebook.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = notebook[indexPath.row]
        cell.textLabel?.text = note.value(forKeyPath: "name") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notebook[indexPath.row]
        
        let noteName = note.value(forKey: "name") as! String
        let noteText = note.value(forKey: "text") as! String
        var noteToSend: [String] = [noteName, noteText]
        performSegue(withIdentifier: "showNote", sender: noteToSend)
    }
    
  
    
}

