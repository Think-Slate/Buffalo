//
//  FirstViewController.swift
//  Buffalo
//
//  Created by Victor Vainberg on 2/7/15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as !AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Print it to the console
        println(managedObjectContext)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  //  @IBOutlet var myTable: UITableView!
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

