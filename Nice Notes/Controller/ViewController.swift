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
    
    //image assets from udacity. i do not own these images. or intend to profit off them. this project is simp
    
    //collection of notes
    //this changed from NSManagedObject to NoteMO becuase we subclassed
    //NSManagedObject and made NoteMO
    var notebook: [NoteMO] = []
    var imagesForNoteCells: [UIImage] = [#imageLiteral(resourceName: "bunny"),#imageLiteral(resourceName: "character"),#imageLiteral(resourceName: "parrot"),#imageLiteral(resourceName: "snail"),#imageLiteral(resourceName: "squirrel"), #imageLiteral(resourceName: "wind")]
    var noteNameToSave: String!
    var noteTextToSave: String!
    
    var dataController: DataController!

    //TODO: implement unique note ID
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this controller acts as the table view delegate
        notesTableView.delegate = self
        //fecth all notes
        let fetchRequest: NSFetchRequest<NoteMO> = NoteMO.fetchRequest()
        //register notes in this context
        if let result = try? dataController.viewContext.fetch(fetchRequest){
            //set data for table view
            notebook = result
            //load data for table view
            notesTableView.reloadData()
        }
    }

    @IBAction func addNote(_ sender: Any) {
        //alert to create and name note upon click to add button
        let alert = UIAlertController(title: "New Note", message: "create a note", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            self.save(name: nameToSave)
            self.notesTableView.reloadData()
        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String){
        //create a note
        let note = NoteMO(context: dataController.viewContext)
        //name the note
        note.name = name
        //save the note name (write the managed object content to the manged object model)
        try? dataController.viewContext.save()
        //add the note to the table view
        notebook.append(note)
    }
    //TODO: implement delete persistence
    func delete(){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote"{
            //controller to travel to
            let noteViewController  = segue.destination as! NoteViewController
            //data to send to other controler
            noteViewController.dataController = dataController
            noteViewController.noteTitle.title = sender as! String
        }
    }
    //TODO: random assignment of note icons
    // use method for implementing random assingment a varieity of note icons
    func selectImageForCell() -> UIImage{
        let index = Int(arc4random_uniform(UInt32(imagesForNoteCells.count)))
        return imagesForNoteCells[index]
    }
    
    //returns number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notebook.count
    }

    //populates table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = notebook[indexPath.row]
        cell.textLabel?.text = note.value(forKeyPath: "name") as? String
        return cell
    }
    
    //handles click event on table cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //upon selection travel to NotesViewController for this cell only
        let note = notebook[indexPath.row]
        performSegue(withIdentifier: "showNote", sender: note.name)
    }
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //slide delete button
        if editingStyle == .delete {
            //removes cell at a givin indexs
            self.notebook.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

