//
//  TaskViewController.swift
//  ToDo App
//
//  Created by Deshant Sharma on 18/04/15.
//  Copyright (c) 2015 Deshant Sharma. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var notesData: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var Title = String()
    var Note = String()
    
    override func viewWillAppear(animated: Bool) {
        taskName.text = Title
        notesData.text = Note
    }
}
