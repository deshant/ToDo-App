//
//  ViewController.swift
//  ToDo App
//
//  Created by Deshant Sharma on 17/04/15.
//  Copyright (c) 2015 Deshant Sharma. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as AppDelegate).managedObjectContext

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBox: UITextField!
    
    
    var titleArray = [String]()
    var notesArray = [String]()
    var foundTitle = String()
    var foundNote = String()
    let cellID = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBox.text = ""
        getData()
        //insert()
    }

    func getData() {
        let entityDescription =
        NSEntityDescription.entityForName("Tasks",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                
                for element in results {
                    let match = element as NSManagedObject
                    
                    if let title: String = match.valueForKey("title") as? String{
                            titleArray.append(title)
                    }
                    if let note: String = match.valueForKey("notes") as? String{
                        notesArray.append(note)
                    }
                }
            }
        }

    }
    //data source methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println(titleArray.count)
        return titleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = titleArray[row]
        
        return cell
    }
    
    //delegate methods
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(titleArray[row])
    }
    */
    
    let SegueIdentifier = "ShowTaskSegue"
    let SearchSegue = "searchSegue"
    let AddTaskSegue = "AddTaskSegue"
    
    // Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        searchBox.resignFirstResponder()
        if segue.identifier == SegueIdentifier {
            if let destination = segue.destinationViewController as? TaskViewController {
                if let Index = tableView.indexPathForSelectedRow()?.row {
                    destination.Title = titleArray[Index]
                    destination.Note = notesArray[Index]
                }
            }
        }
        else if segue.identifier == SearchSegue {
            if let destination = segue.destinationViewController as? TaskViewController {
                destination.Title = foundTitle
                destination.Note = foundNote
            }
        }
        else if segue.identifier == AddTaskSegue {
            if let destination = segue.destinationViewController as? AddTaskController {
                
            }
        }
    }
    
    // search Box
    @IBAction func searchTask(sender: AnyObject) {
        searchBox.resignFirstResponder()
        var inputText = searchBox.text!
        
        let entityDescription =
        NSEntityDescription.entityForName("Tasks",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(title = %@)", inputText)
        request.predicate = pred
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[0] as NSManagedObject
                foundTitle = match.valueForKey("title") as String
                foundNote = match.valueForKey("notes") as String
                performSegueWithIdentifier(SearchSegue, sender: self)
            }
            else {
                searchBox.text = "Task not found"
            }
            }
        }
    @IBAction func deleteTask(sender: AnyObject) {
        searchBox.resignFirstResponder()
        var inputText = searchBox.text!
        
        let entityDescription =
        NSEntityDescription.entityForName("Tasks",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        request.includesSubentities = false
        request.returnsObjectsAsFaults = false
        
        let pred = NSPredicate(format: "(title = %@)", inputText)
        request.predicate = pred
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                for item in results {
                    managedObjectContext?.deleteObject(item as NSManagedObject)
                }
                
               searchBox.text = "Task(s) removed" 
            }
            else {
                searchBox.text = "Task not found"
            }
        }
        
    }
}