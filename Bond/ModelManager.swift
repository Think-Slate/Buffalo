//
//  ModelManager.swift
//  BOND by THINK~SLATE
//
//  Created by Victor Vainberg on 1/17/15.
//  Copyright (c) 2015 Victor Vainberg. All rights reserved.
//

import Foundation
import UIKit
let sharedInstance = ModelManager()
class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    class var instance: ModelManager {
        sharedInstance.database = FMDatabase(path: "/Users/VictorVainberg/Desktop/Bond/Buffalo/bondData.db")
        var path = "/Users/VictorVainberg/Desktop/Bond/Buffalo/bondData.db"
        println("Path: \(path)")
        return sharedInstance
    }
    
    func addUserData(accntsInfo: userAccnts) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO userAccnts  VALUES (?, ?, ? ,?)", withArgumentsInArray: [accntsInfo.email, accntsInfo.firstName, accntsInfo.lastName, accntsInfo.passwd])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func forgotPasswd(accntsInfo: userAccnts, newPasswd: String) -> Bool {
        sharedInstance.database!.open()
        let  fixForgotten = sharedInstance.database!.executeUpdate("UPDATE userAccnts SET passwd=? WHERE email=?", withArgumentsInArray: [newPasswd, accntsInfo.email])
        sharedInstance.database!.close()
        return fixForgotten
    }
    
    func deleteAccntData(accntsInfo: userAccnts) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM userAccnts WHERE email=?", withArgumentsInArray: [accntsInfo.email])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func checkExists(email_label: String) -> Bool
    {
        sharedInstance.database!.open()
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT email FROM userAccnts where email=?" , withArgumentsInArray: [email_label])
        if(resultSet.next() == false)
        {

            return false
        }
        
        else
        {
            return true
        }
    }
    
    func checkExistingGroup(groupName: String) -> Bool
    {
        sharedInstance.database!.open()
        var resultSet: FMResultSet! =   sharedInstance.database!.executeQuery("SELECT gpass FROM groups WHERE groupname =?", withArgumentsInArray: [groupName])
        
        if (resultSet.next() == false)
        {
               return  false
        }
        
        else
        {
            return true
        }

    }
    
//    func joinGroup(groupName: String)
//    {
//        sharedInstance.database!.open()
//        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO members VALUES(?, ?)", withArgumentsInArray: [currentUser.email, groupName])
//     //  sharedInstance.database!.close()
//    }
    
    func createNewGroup(groupName: String, GroupPass: String, matchTime: NSDate)
    {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO groups  VALUES (?, ?, ? ,?)", withArgumentsInArray: [groupName,GroupPass, currentUser.email, matchTime])
      //  sharedInstance.database!.close()
    }
    
    func checkGroupJoin(group_name : String, group_password : String) -> Bool
    {
        sharedInstance.database!.open()
        var passwdCol: String = "gpass"
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT gpass FROM groups where groupname =?", withArgumentsInArray: [group_name])
        if(resultSet.next() == false || resultSet.stringForColumn(passwdCol) != group_password)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func checkSignIn(email_label : String, passwd_label: String) -> Bool
    {
        sharedInstance.database!.open()
        var passwdCol: String = "passwd"
        var resultSet: FMResultSet! =   sharedInstance.database!.executeQuery("SELECT passwd FROM userAccnts where email =?", withArgumentsInArray: [email_label])
        if (resultSet.next() == false || resultSet.stringForColumn(passwdCol) != passwd_label)
        {
            
            return false
        }
        
        else
        {
            return true
        }
    }
    
    func getAccountInfo(email_label : String) -> Array<String>
    {
        sharedInstance.database!.open()
        var userArray = Array<String>()
        var passwdCol: String = "passwd"
        var resultSet: FMResultSet! =   sharedInstance.database!.executeQuery("SELECT * FROM userAccnts where email =?", withArgumentsInArray: [email_label])
        if (resultSet.next() == false)
        {
            return userArray
        }
            
        else
        {
            userArray = [resultSet.stringForColumn("email"),resultSet.stringForColumn("firstName"),resultSet.stringForColumn("lastName"),resultSet.stringForColumn("passwd")]
            return userArray
        }
    }
    
    func getAllAccntsData() {
        sharedInstance.database!.open()
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM userAccnts", withArgumentsInArray: nil)
        var emailCol: String = "email"
        var firstNameCol: String = "firstName"
        var lastNameCol: String = "lastName"
        var passwdCol: String = "passwd"
        if (resultSet != nil) {
            while resultSet.next() {
                println("email : \(resultSet.stringForColumn(emailCol))")
                println("First : \(resultSet.stringForColumn(firstNameCol))")
                println("Last : \(resultSet.stringForColumn(lastNameCol))")
                println("Password: \(resultSet.stringForColumn(passwdCol))")
            }
         
        }
       // sharedInstance.database!.close()
    }
    
}