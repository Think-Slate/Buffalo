//
//  RegisterViewController.swift
//  Buffalo
//
//  Created by Victor Vainberg on 2/7/15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var tagField: UIButton!
    
    @IBAction func letsGoBut(sender: AnyObject) {
        self.performSegueWithIdentifier("firstTagSeg", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

