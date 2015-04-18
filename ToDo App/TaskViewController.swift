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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var blogName = String()
    
    override func viewWillAppear(animated: Bool) {
        taskName.text = blogName
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
