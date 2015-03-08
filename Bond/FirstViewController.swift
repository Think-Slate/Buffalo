//
//  FirstViewController.swift
//  Buffalo
//
//  Created by Victor Vainberg on 2/7/15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Print it to the console
        let newItem: Contact = NSEntityDescription.insertNewObjectForEntityForName("LogItem", inManagedObjectContext: self.managedObjectContext!) as Contact
        newItem.firstName  = "Don"
        newItem.lastName = "Quijote"
        newItem.email = "donQuijo@gmail.com"
        newItem.age = 74
        newItem.link = "abajoBerenjena.blogspot.com"
        
        println(managedObjectContext)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
