//
//  accntsInfo.swift
//  BigLittle
//
//  Created by Victor Vainberg on 1/17/15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import Foundation
import UIKit

let currentUser = userAccnts()

class userAccnts: NSObject {
    
    var email: String = String()
    var firstName: String = String()
    var lastName: String = String()
    var passwd: String = String()
    var id: Int = Int()
    var link: String = String()
    
    func initialize(Email: String, firstName: String, lastName: String, passwd: String, id: Int, link: String){
        self.email = Email
        self.firstName = firstName
        self.lastName = lastName
        self.passwd = passwd
        self.id = id
        self.link = link
    }
    
    func logOut(){
        self.email = String()
        self.firstName = String()
        self.lastName = String()
        self.passwd = String()
        self.id = Int()
        self.link = String()
    }
}
