//
//  AddTaskController.swift
//  ToDo App
//
//  Created by Deshant Sharma on 19/04/15.
//  Copyright (c) 2015 Deshant Sharma. All rights reserved.
//

import UIKit
import CoreData

class AddTaskController: UIViewController {
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as AppDelegate).managedObjectContext

    @IBOutlet weak var Title: UITextField!
    @IBOutlet weak var Notes: UITextField!
    @IBOutlet weak var Status: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Status.text = ""

    }
    override func viewWillDisappear(animated: Bool) {
        
    }
    @IBAction func SaveTask(sender: AnyObject) {
        if Title.text != "" && Notes.text != "" {
            let entityDescription =
            NSEntityDescription.entityForName("Tasks",
                inManagedObjectContext: managedObjectContext!)
            
            let task = Tasks(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            task.title = Title.text
            task.notes = Notes.text
            
            var error: NSError?
            
            managedObjectContext?.save(&error)
            
            if let err = error {
                Status.text = "Cannot Save"
            }
            else {
                Title.text = ""
                Notes.text = ""
                Status.text = "Task Saved"
            }
        }
    }
}
