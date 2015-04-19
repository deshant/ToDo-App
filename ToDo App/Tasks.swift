//
//  Tasks.swift
//  ToDo App
//
//  Created by Deshant Sharma on 19/04/15.
//  Copyright (c) 2015 Deshant Sharma. All rights reserved.
//

import Foundation
import CoreData

class Tasks: NSManagedObject {

    @NSManaged var notes: String
    @NSManaged var title: String

}
