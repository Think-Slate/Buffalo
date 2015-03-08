//
//  Contact.swift
//  Bond
//
//  Created by Victor Vainberg on 2/25/15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import Foundation
import CoreData

class Contact: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var email: String
    @NSManaged var age: NSNumber
    @NSManaged var link: String
    
}
