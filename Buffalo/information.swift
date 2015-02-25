//
//  information.swift
//  Buffalo
//
//  Created by Victor Vainberg on 2/20/15 for Think~Slate W'15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import Foundation


class Information: NSObject
{
                private
                    var firstName: String
                    var lastName: String
                    var email: String
                    var age: Int
                    var link: String
                    //var pic:
                   
                    
                    init(firstName_a: String, lastName_a: String, email_a: String, age_a: Int, link_a: String)
                    {
                        self.firstName = firstName_a
                        self.lastName = lastName_a
                        self.email = email_a
                        self.age = age_a
                        self.link = link_a
                    }
                
                internal
                // Get Funcitons
                func get_first() -> String
                {return self.firstName}
                
                func get_last() -> String
                {return self.lastName}
                
                func get_email() -> String
                {return self.email}
                
                func get_age() -> Int
                {return self.age}
                
                func get_link() -> String
                {return self.link}
    
}
