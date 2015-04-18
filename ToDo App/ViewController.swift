//
//  ViewController.swift
//  ToDo App
//
//  Created by Deshant Sharma on 17/04/15.
//  Copyright (c) 2015 Deshant Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBox: UITextField!
    
    
    let testArray = ["Cell one","Cell Two","Cell Three","Cell four"]
    let cellID = "textCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBox.text = ""
    }
    
    //data source methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = testArray[row]
        
        return cell
    }
    
    //delegate methods
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(testArray[row])
    }
    */
    let SegueIdentifier = "ShowTaskSegue"
    let SearchSegue = "searchSegue"
    var i = 0
    
    // Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        searchBox.resignFirstResponder()
        if segue.identifier == SegueIdentifier {
            if let destination = segue.destinationViewController as? TaskViewController {
                if let Index = tableView.indexPathForSelectedRow()?.row {
                    destination.Name = testArray[Index]
                }
            }
        }
        else if segue.identifier == SearchSegue {
            if let destination = segue.destinationViewController as? TaskViewController {
                    destination.Name = testArray[i]
            }
        }
    }
    
    // search Box
    @IBAction func searchTask(sender: AnyObject) {
        searchBox.resignFirstResponder()
        var inputText = searchBox.text!
        i = 0
        for element in testArray{
            if element == inputText {
                performSegueWithIdentifier(SearchSegue, sender: self)
                break
            }
            i++
        }
        searchBox.text = "Task not found"
    }

}