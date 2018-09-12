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
    var names: [String] = []
    var imagesForNoteCells: [UIImage] = [#imageLiteral(resourceName: "bunny"),#imageLiteral(resourceName: "character"),#imageLiteral(resourceName: "parrot"),#imageLiteral(resourceName: "snail"),#imageLiteral(resourceName: "squirrel"), #imageLiteral(resourceName: "wind")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        notesTableView.delegate = self
    }
    
    
    @IBAction func addNote(_ sender: Any) {
     
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.names.append(nameToSave)
                                        self.notesTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

    func selectImageForCell() -> UIImage{
        let index = Int(arc4random_uniform(UInt32(imagesForNoteCells.count)))
        return imagesForNoteCells[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return names.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
                cell.textLabel?.text = names[indexPath.row]
                return cell
    }
    
}

