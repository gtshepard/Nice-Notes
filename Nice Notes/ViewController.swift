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
    var notebook: [NSManagedObject] = []
    var imagesForNoteCells: [UIImage] = [#imageLiteral(resourceName: "bunny"),#imageLiteral(resourceName: "character"),#imageLiteral(resourceName: "parrot"),#imageLiteral(resourceName: "snail"),#imageLiteral(resourceName: "squirrel"), #imageLiteral(resourceName: "wind")]
    var noteNameToSave: String!
    var noteTextToSave: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: variables do not load before this call so you are always one note behind.
        //no method in between viewWillAppear, and viewDidAppear. viewDidAppear has no use becuase the UI has already been dispayed so you dont see the data which is waste.
        //you want the same notebook to accessable to both this viewController and the NoteViewController so you save ntoes in that controller and not deal woth this weird bandaidfix that doesnt even work in view will appear.
        //the problem with having 2 notebook objects is the fact that you need to have them both up to date, or whats the point? and plus youd have twice the data, not very efficcient both controllers are making edits to the notebook. you could always pass this notbook to the other notbook, but again you still have 2  seperate copies of a not book, and thats still 2 times the data! Bad, really bad. there must be a better way! and there is! multiple managed object contexts in core data! mwhen multiple view controllers are eidtiing the the data model this a msut. Rays, example app for this a journal. a note pad and a journal basically the same thing!! and you came to this conclsuion on your own! way to go!
            saveNoteData{ ()->() in fetchNoteData()}
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //MARK: race codnition becuase fethc request is opened on a seperate thread. the fecth request doesnt alwasy finish before view Did appear is called and this can create probelsm if it does not finsih fetching the data. the notebook may not be up to date! therefore if the notebook is not up to date a value may not exist in the notebook because the data has not loaded, but noteTextToSave will always have a value becuause it had one previously. becusse we have created a note in th past. soemtimes the note doesnt exist, so what happens when it doesnt. this is the section of the code where you store the ntoes text, if you cant save it, it does nto get put in. also the value for the text,could get the wrong value because it the value doesnt exist, then the note book is updated and all the sudden a vlaue does exsit,

    }
    
    
    @IBAction func addNote(_ sender: Any) {
     
        let alert = UIAlertController(title: "New Note", message: "Name the note", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .default) {
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
    
    func fetchNoteData(){
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            notebook = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print("EXECUTE SECOND")
   
    }
    
    
    func saveNoteData(completion: ()->()){
        print("EXECUTE FIRST")
        
        if let noteText = noteTextToSave {
     
            //saves every time, even if text hasnt changed. wasteful and may be contributing to the bug
            for note in notebook {
                
                if note.value(forKey: "name") as! String == noteNameToSave! {
                    print("NOTE EXISTS")
                    note.setValue(noteText, forKey: "text")
                    print(noteText)
                    completion()
                    return
                } else{
                    print("NOTE DOES NOT EXIST")
                }
            }
            print("SAVE AND RELOAD CALLED")
            //save(name: noteNameToSave!, text: noteTextToSave!)
            //notesTableView.reloadData()
        }
                print("NO DATA TO SAVE")
        completion()
    }
    
    func save(name: String, text: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
    
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
       note.setValue(name, forKeyPath: "name")
       note.setValue(text, forKeyPath: "text")
        
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
        let noteToSend: [String] = [noteName, noteText]
        performSegue(withIdentifier: "showNote", sender: noteToSend)
    }
}

